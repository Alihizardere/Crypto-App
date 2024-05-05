//
//  Format+Extension.swift
//  Crypto-App
//
//  Created by alihizardere on 5.05.2024.
//

import Foundation

extension Double {
    func formattedPrice() -> String {

        let priceComponents = String(format: "%.5f", self).split(separator: ".")

        let formattedInteger = String(priceComponents[0]).enumerated().map { index, digit in
            return index > 0 && (priceComponents[0].count - index) % 3 == 0 ? "." + String(digit) : String(digit)
        }.joined()

        let formattedDecimal = String(priceComponents.count > 1 ? priceComponents[1].prefix(5) : "00000")

        if formattedDecimal == "00000" {
            return formattedInteger
        } else {
            return "\(formattedInteger),\(formattedDecimal)"
        }
    }
}
