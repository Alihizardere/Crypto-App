//
//  UIView+Extension.swift
//  Crypto-App
//
//  Created by alihizardere on 6.05.2024.
//

import UIKit

extension UIView {
  func addShadow(color: UIColor = .black, opacity: Float = 0.5, offset: CGSize = CGSize(width: 0, height: 2), radius: CGFloat = 2, cornerRadius: CGFloat = 5) {
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offset
    layer.shadowRadius = radius
    layer.cornerRadius = cornerRadius
    layer.masksToBounds = false
  }
  
  func setBackgroundGradient(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = colors.map { $0.cgColor }
    gradientLayer.startPoint = startPoint
    gradientLayer.endPoint = endPoint
    gradientLayer.frame = bounds

    layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
    layer.insertSublayer(gradientLayer, at: 0)
  }
}
