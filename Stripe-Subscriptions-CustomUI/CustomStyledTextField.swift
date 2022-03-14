//
//  CustomStyledTextField.swift
//  Stripe-Subscriptions-CustomUI
//
//  Created by Dinesh Vijaykumar on 14/03/2022.
//

import SwiftUI

/// A custom styled TextField with an SF symbol icon.
struct CustomStyledTextField: View {
    @Binding var text: String
    let placeholder: String
    let symbolName: String
    let keyboardType: UIKeyboardType
    let formatter: ((String?) -> String?)?

    init(text: Binding<String>, placeholder: String, symbolName: String, keyboardType: UIKeyboardType = .asciiCapable, formatter: ((String?) -> String?)? = nil) {
        self._text = text
        self.placeholder = placeholder
        self.symbolName = symbolName
        self.keyboardType = keyboardType
        self.formatter = formatter
    }

    var body: some View {
        HStack {
            Image(systemName: symbolName)
                .imageScale(.large)
                .padding(.leading)

            TextField(placeholder, text: $text)
                .padding(.vertical)
                .accentColor(.orange)
                .autocapitalization(.none)
                .keyboardType(keyboardType)
                .onChange(of: self.text, perform: { value in
                    guard let formatter = formatter else { return }

                    self.text = formatter(value) ?? self.text
                })
        }
        .background(
            RoundedRectangle(cornerRadius: 16.0, style: .circular)
                .foregroundColor(Color(.secondarySystemFill))
        )
    }
}
