//
//  TextFormatter.swift
//  Stripe-Subscriptions-CustomUI
//
//  Created by Dinesh Vijaykumar on 14/03/2022.
//

import AnyFormatKit
import Foundation

class CardNumberTextFormatter: TextFormatable {
    let formatter = DefaultTextInputFormatter(textPattern: "#### #### #### ####")

    func format(_ str: String?) -> String? {
        let unformattedText = formatter.unformat(str)
        return formatter.format(unformattedText)
    }
}

class CardExpDateFormatter: TextFormatable {
    let formatter = DefaultTextInputFormatter(textPattern: "##/##")

    func format(_ str: String?) -> String? {
        let unformattedText = formatter.unformat(str)
        return formatter.format(unformattedText)
    }
}

class CardCVVFormatter: TextFormatable {
    let formatter = DefaultTextInputFormatter(textPattern: "###")

    func format(_ str: String?) -> String? {
        let unformattedText = formatter.unformat(str)
        return formatter.format(unformattedText)
    }
}

protocol TextFormatable {
    func format(_ str: String?) -> String?
}
