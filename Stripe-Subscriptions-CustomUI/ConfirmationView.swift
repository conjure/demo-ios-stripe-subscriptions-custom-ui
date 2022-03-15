//
//  ConfirmationView.swift
//  Stripe-Subscriptions-CustomUI
//
//  Created by Dinesh Vijaykumar on 15/03/2022.
//

import SwiftUI

struct ConfirmationView: View {
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()

            Text("Subscription successfully created")
                .font(.largeTitle)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView()
    }
}
