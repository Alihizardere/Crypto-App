//
//  CustomTabBar.swift
//  Crypto-App
//
//  Created by alihizardere on 9.05.2024.
//

import UIKit

class CustomTabBar: UITabBarController {
  
  // MARK: - Properties
  let btnMiddle: UIButton = {
    let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    btn.setTitle("", for: .normal)

    // MARK: - Gradient Color
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [
      UIColor.purple.withAlphaComponent(0.8).cgColor,
      UIColor.systemBlue.cgColor
    ]
    gradientLayer.startPoint = CGPoint(x: 0, y: 1)
    gradientLayer.endPoint = CGPoint(x: 1, y: 0)
    gradientLayer.frame = btn.bounds
    gradientLayer.cornerRadius = 25
    btn.layer.insertSublayer(gradientLayer, at: 0)

    // MARK: - Shadowing
    btn.layer.shadowColor = UIColor.black.cgColor
    btn.layer.shadowOpacity = 0.3
    btn.layer.shadowOffset = CGSize(width: 0, height: 4)

    // MARK: - Setup Image
    if let originalImage = UIImage(named: "tradeIcon") {
      let tintedCameraImage = originalImage.withTintColor(.white)
      let imageView = UIImageView(image: tintedCameraImage)
      imageView.contentMode = .scaleAspectFill
      imageView.frame = btn.bounds
      btn.addSubview(imageView)
    }
    return btn
  }()

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    btnMiddle.frame = CGRect(x: Int(tabBar.bounds.width)/2 - 25, y: -23, width: 50, height: 50)
  }

  override func loadView() {
    super.loadView()
    tabBar.addSubview(btnMiddle)
    setupCustomTabbar()
  }

  private func setupCustomTabbar() {
    let path: UIBezierPath = getPathForTabbar()
    let shape = CAShapeLayer()
    shape.path = path.cgPath
    shape.lineWidth = 2
    shape.strokeColor = UIColor.white.cgColor
    shape.fillColor = UIColor.white.cgColor
    tabBar.layer.insertSublayer(shape, at: 0)
    tabBar.itemWidth = 40
    tabBar.itemPositioning = .centered
    tabBar.itemSpacing = 180
    tabBar.unselectedItemTintColor = .white
    tabBar.tintColor = .white
  }

  private func getPathForTabbar() -> UIBezierPath {
    let frameWidth = tabBar.bounds.width
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: frameWidth , y: 0))
    path.addArc(withCenter: CGPoint(x: frameWidth/2, y: 0), radius: CGFloat(30), startAngle: CGFloat(Float.pi), endAngle: CGFloat(2*Float.pi), clockwise: false)
    path.close()
    return path
  }
}
