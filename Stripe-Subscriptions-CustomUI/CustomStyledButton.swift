//
//  CustomStyledButton.swift
//  Stripe-Subscriptions-CustomUI
//
//  Created by Dinesh Vijaykumar on 14/03/2022.
//

import SwiftUI

/// A custom styled button with a custom title and action.
struct CustomStyledButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            /// Embed in an HStack to display a wide button with centered text.
            HStack {
                Spacer()
                Text(title)
                    .padding()
                    .accentColor(.white)
                Spacer()
            }
        }
        .background(Color.orange)
        .cornerRadius(16.0)
    }
}
