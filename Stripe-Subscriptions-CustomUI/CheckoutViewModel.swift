//
//  CheckoutViewModel.swift
//  Stripe-Subscriptions-CustomUI
//
//  Created by Dinesh Vijaykumar on 15/03/2022.
//

import Foundation
import SwiftUI
import Stripe

class CheckoutViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case failed
        case success
    }
    @Published var state = State.idle
    @Published var showDetail = false

    func createPaymentMethod(cardNumber: String, expDate:String, cvv: String) {
        let components = expDate.components(separatedBy: "/")
        guard components.count == 2, let expMonth = components.first, let expYear = components.last else { return }
        guard let expMonthInt = Int(expMonth), let expYearInt = Int(expYear) else { return }

        let result = STPPaymentMethodCardParams()
        result.number = cardNumber
        result.expMonth = NSNumber(value: expMonthInt)
        result.expYear = NSNumber(value: expYearInt)
        result.cvc = cvv
        let paymentMethodParams = STPPaymentMethodParams(card: result, billingDetails: nil, metadata: nil)

        self.state = .loading

        STPAPIClient.shared.createPaymentMethod(with: paymentMethodParams) { paymentMethod, error in
            if let createError = error {
                print("Error creating Payment Method \(createError)")
                self.state = .failed
                return
            }

            if paymentMethod != nil {
                self.payForSubscription(paymentMethod!.stripeId)
            }
        }
    }

    private func payForSubscription(_ paymentMethodId: String) {
        guard let url = URL(string: Constants.backendUrl)?.appendingPathComponent("/subscribe") else { return }

        let body: [String: Any] = [
            "email": "testUser@example.com",
            "paymentMethodId": paymentMethodId,
            "priceID": Constants.priceID
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                let customer = json["customer"] as? String,
                let clientSecret = json["paymentIntent"] as? String
            else {
                let message = error?.localizedDescription ?? "Failed to decode response from server."
                self?.state = .failed
                print("Error - \(message)")
                return
            }

            DispatchQueue.main.async {
                self?.state = .success
                self?.showDetail = true
                let message = "Customer \(customer) has been created"
                print(message)
                print("Client Secret - \(clientSecret)")
            }
        })

        task.resume()
    }
}
