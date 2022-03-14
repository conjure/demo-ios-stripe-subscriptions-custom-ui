//
//  ContentView.swift
//  Stripe-Subscriptions-CustomUI
//
//  Created by Dinesh Vijaykumar on 14/03/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var cardNumber: String = ""
    @State private var cardExpiry: String = ""
    @State private var cardCVC: String = ""

    @State private var country: String = ""
    @State private var postcode: String = ""

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

                Text("Country or region")
                    .bold()
                    .padding(.top, 15)

                CustomStyledTextField(
                    text: $country, placeholder: "Country", symbolName: "map", keyboardType: .asciiCapable
                )

                CustomStyledTextField(
                    text: $postcode, placeholder: "Postcode", symbolName: "house", keyboardType: .asciiCapable
                )

                CustomStyledButton(title: "Pay £9.99 a month", action: submitPayment)
                    .disabled(shouldDisableButton)

                Spacer()
            }
            .padding()
            .navigationBarTitle("Stripe Subscriptions")
        }
    }

    private func submitPayment() {

    }

    private var shouldDisableButton: Bool {
        cardNumber.isEmpty || cardCVC.isEmpty || cardExpiry.isEmpty || postcode.isEmpty || country.isEmpty
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
