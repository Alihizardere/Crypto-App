//
//  UIView+Extension.swift
//  Crypto-App
//
//  Created by alihizardere on 6.05.2024.
//

import UIKit

extension UIView {

    func addShadow(color: UIColor = .black, opacity: Float = 0.5, offset: CGSize = CGSize(width: 2, height: 2), radius: CGFloat = 4, cornerRadius: CGFloat = 5) {

           layer.shadowColor = color.cgColor
           layer.shadowOpacity = opacity
           layer.shadowOffset = offset
           layer.shadowRadius = radius
           layer.cornerRadius = cornerRadius
           layer.masksToBounds = false
       }
}
