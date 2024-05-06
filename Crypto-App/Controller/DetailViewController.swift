//
//  DetailViewController.swift
//  Crypto-App
//
//  Created by alihizardere on 6.05.2024.
//

import UIKit

class DetailViewController: UIViewController {

  // MARK: - Properties
  var selectedCoin: Coin?
  var sparklineDataStrings = [String]()
  var sparklineData: [Double] = []
  @IBOutlet weak var highLabel: UILabel!
  @IBOutlet weak var lowLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var changeLabel: UILabel!


  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    guard let coin = selectedCoin else { return }
    priceLabel.text = "$\(Double(coin.price)?.formattedPrice(decimalCount: 5) ?? "0.0")"
    changeLabel.text = "\(coin.change)%"

    navigationController?.navigationBar.prefersLargeTitles = false

    let titleView = CustomTitleView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
    titleView.titleLabel.text = coin.name
    titleView.subtitleLabel.text =  coin.symbol
    navigationItem.titleView = titleView
    sparklineDataStrings = coin.sparkline
    convertSparklineData()
    drawSparkline()
  }

  func convertSparklineData() {
    for stringData in sparklineDataStrings {
      if let doubleValue = Double(stringData) {
        sparklineData.append(doubleValue)
      }
    }
  }

  func drawSparkline() {
    let sparklineView = UIView(frame: CGRect(x: 10, y: 300, width: view.frame.width - 20, height: view.frame.height/3))
    sparklineView.backgroundColor = .clear
    view.addSubview(sparklineView)

    let maxValue = sparklineData.max() ?? 0
    let minValue = sparklineData.min() ?? 0
    let dataRange = CGFloat(maxValue - minValue)

    highLabel.text = "\(maxValue.formattedPrice(decimalCount: 2))"
    lowLabel.text = "\(minValue.formattedPrice(decimalCount: 2))"

    let dataCount = sparklineData.count
    let columnWidth = sparklineView.frame.width / CGFloat(dataCount - 1)

    var previousPoint = CGPoint(x: 0, y: calculateYCoordinate(data: sparklineData[0], minValue: minValue, dataRange: dataRange))

    for i in 1..<dataCount {
      let x = CGFloat(i) * columnWidth
      let y = calculateYCoordinate(data: sparklineData[i], minValue: minValue, dataRange: dataRange)
      let currentPoint = CGPoint(x: x, y: y)

      let linePath = UIBezierPath()
      linePath.move(to: previousPoint)
      linePath.addLine(to: currentPoint)

      let lineLayer = CAShapeLayer()
      lineLayer.path = linePath.cgPath
      lineLayer.strokeColor = UIColor.blue.cgColor
      lineLayer.lineWidth = 1.5
      lineLayer.fillColor = UIColor.red.cgColor

      sparklineView.layer.addSublayer(lineLayer)

      previousPoint = currentPoint
    }
  }
  
  func calculateYCoordinate(data: CGFloat, minValue: CGFloat, dataRange: CGFloat) -> CGFloat {
    let normalizedValue = CGFloat(data - minValue) / dataRange
    return 100 * (1 - normalizedValue)
  }
}
