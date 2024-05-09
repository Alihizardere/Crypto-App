//
//  CustomChart.swift
//  Crypto-App
//
//  Created by alihizardere on 7.05.2024.
//

import UIKit

class ChartView: UIView {

  var sparklineData: [Double] = [] {
    didSet { setNeedsDisplay() }
  }

  override func draw(_ rect: CGRect) {
    super.draw(rect)
    drawSparkline()
  }

  private func drawSparkline() {
    guard !sparklineData.isEmpty else { return }

    let maxValue = sparklineData.max() ?? 0
    let minValue = sparklineData.min() ?? 0
    let dataRange = CGFloat(maxValue - minValue)

    let dataCount = sparklineData.count
    let columnWidth = bounds.width / CGFloat(dataCount - 1)
    var previousPoint = CGPoint(x: 0, y: calculateYCoordinate(data: sparklineData[0], minValue: minValue, dataRange: dataRange))

    let fillPath = UIBezierPath()
    fillPath.move(to: previousPoint)

    for i in 1..<dataCount {
      let x = CGFloat(i) * columnWidth
      let y = calculateYCoordinate(data: sparklineData[i], minValue: minValue, dataRange: dataRange)
      let currentPoint = CGPoint(x: x, y: y)
      fillPath.addLine(to: currentPoint)

      let linePath = UIBezierPath()
      linePath.move(to: previousPoint)
      linePath.addLine(to: currentPoint)

      let lineLayer = CAShapeLayer()
      lineLayer.path = linePath.cgPath
      lineLayer.strokeColor = UIColor(named: "color")?.cgColor
      lineLayer.lineWidth = 2
      layer.addSublayer(lineLayer)

      previousPoint = currentPoint
    }

    fillPath.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
    fillPath.addLine(to: CGPoint(x: 0, y: bounds.height))
    fillPath.close()

    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = bounds
    gradientLayer.colors = [UIColor.blue.withAlphaComponent(0.3).cgColor, UIColor.white.withAlphaComponent(0.6).cgColor]
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)

    let maskLayer = CAShapeLayer()
    maskLayer.path = fillPath.cgPath
    gradientLayer.mask = maskLayer
    layer.addSublayer(gradientLayer)
  }

  private func calculateYCoordinate(data: CGFloat, minValue: CGFloat, dataRange: CGFloat) -> CGFloat {
    let normalizedValue = CGFloat(data - minValue) / dataRange
    return bounds.height * (1 - normalizedValue)
  }
}
