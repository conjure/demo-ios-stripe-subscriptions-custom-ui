//
//  CheckoutViewController.swift
//  Stripe-Subscriptions-CustomUI
//
//  Created by Dinesh Vijaykumar on 16/03/2022.
//

import UIKit
import PassKit
import StripeApplePay

class CheckoutViewController: UIViewController, ApplePayContextDelegate {
    let applePayButton: PKPaymentButton = PKPaymentButton(paymentButtonType: .plain, paymentButtonStyle: .black)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(applePayButton)

        // Only offer Apple Pay if the customer can pay with it
        applePayButton.isHidden = !StripeAPI.deviceSupportsApplePay()
        applePayButton.addTarget(self, action: #selector(handleApplePayButtonTapped), for: .touchUpInside)
    }

    @objc func handleApplePayButtonTapped() {
        let merchantIdentifier = Constants.merchantID
        let paymentRequest = StripeAPI.paymentRequest(withMerchantIdentifier: merchantIdentifier, country: "GB", currency: "GBP")

        // Configure the line items on the payment request
        paymentRequest.paymentSummaryItems = [
            // The final line should represent your company;
            // it'll be prepended with the word "Pay" (that is, "Pay Example, Inc £9.99")
            PKPaymentSummaryItem(label: "Example, Inc", amount: 9.99),
        ]

        // Initialize an STPApplePayContext instance
        if let applePayContext = STPApplePayContext(paymentRequest: paymentRequest, delegate: self) {
            // Present Apple Pay payment sheet
            applePayContext.presentApplePay()
        } else {
            // There is a problem with your Apple Pay configuration
        }
    }
}

extension CheckoutViewController {
    func applePayContext(_ context: STPApplePayContext, didCreatePaymentMethod paymentMethod: StripeAPI.PaymentMethod, paymentInformation: PKPayment, completion: @escaping STPIntentClientSecretCompletionBlock) {
        let clientSecret = "" // Retrieve the PaymentIntent client secret from the backend
        // Call the completion block with the client secret or an error
        completion(clientSecret, nil)
    }

    func applePayContext(_ context: STPApplePayContext, didCompleteWith status: STPApplePayContext.PaymentStatus, error: Error?) {
        switch status {
        case .success:
            // Payment succeeded, show a receipt view
            break
        case .error:
            // Payment failed, show the error
            break
        case .userCancellation:
            // User canceled the payment
            break
        }
    }
}
