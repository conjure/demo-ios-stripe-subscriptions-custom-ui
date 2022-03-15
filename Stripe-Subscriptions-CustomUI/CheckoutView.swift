//
//  CheckoutView.swift
//  Stripe-Subscriptions-CustomUI
//
//  Created by Dinesh Vijaykumar on 14/03/2022.
//

import SwiftUI

struct CheckoutView: View {
    @State private var cardNumber: String = ""
    @State private var cardExpiry: String = ""
    @State private var cardCVC: String = ""

    @StateObject var viewModel = CheckoutViewModel()

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Create a subscription on Stripe using a custom UI")
                    .padding(.bottom, 25)

                Text("Card Information")
                    .bold()

                CustomStyledTextField(
                    text: $cardNumber, placeholder: "Card number", symbolName: "creditcard", keyboardType: .numberPad) { val in
                        CardNumberTextFormatter().format(val) ?? val
                    }

                HStack {
                    CustomStyledTextField(
                        text: $cardExpiry, placeholder: "MM/YY", symbolName: "calendar", keyboardType: .numberPad
                    ) { val in
                        CardExpDateFormatter().format(val)
                    }

                    CustomStyledTextField(
                        text: $cardCVC, placeholder: "CVC", symbolName: "creditcard.and.123", keyboardType: .numberPad) { val in
                            CardCVVFormatter().format(val) ?? val
                        }
                }

                if viewModel.state == .loading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .scaleEffect(1.5)
                }

                NavigationLink(isActive: $viewModel.showDetail) {
                    ConfirmationView()
                } label: {
                    EmptyView()
                }

                Spacer()

                CustomStyledButton(title: "Pay £9.99 a month", action: submitPayment)
                    .disabled(shouldDisableButton)
            }
            .padding()
            .navigationBarTitle("Stripe Subscriptions")
        }
    }

    private func submitPayment() {
        self.viewModel.createPaymentMethod(cardNumber: cardNumber, expDate: cardExpiry, cvv: cardCVC)
    }

    private var shouldDisableButton: Bool {
        cardNumber.isEmpty || cardCVC.isEmpty || cardExpiry.isEmpty || viewModel.state == .loading
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
