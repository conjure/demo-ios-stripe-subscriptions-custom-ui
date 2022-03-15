//
//  Stripe_Subscriptions_CustomUIApp.swift
//  Stripe-Subscriptions-CustomUI
//
//  Created by Dinesh Vijaykumar on 14/03/2022.
//

import SwiftUI
import StripeCore

@main
struct Stripe_Subscriptions_CustomUIApp: App {

    init() {
        StripeAPI.defaultPublishableKey = Constants.stripePublishableKey
    }

    var body: some Scene {
        WindowGroup {
            CheckoutView()
        }
    }
}
