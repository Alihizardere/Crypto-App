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
  @IBOutlet weak var chartView: ChartView!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = false
    setupSelectedCoin()
    convertSparklineData()
    setupDetailInfo()
    chartView.sparklineData = sparklineData

  }

  // MARK: - Functions
  private func setupSelectedCoin(){
    guard let coin = selectedCoin else { return }
    priceLabel.text = "$\(Double(coin.price)?.formattedPrice(decimalCount: 5) ?? "0.0")"
    changeLabel.text = "\(coin.change)%"
    let titleView = NavbarTitleView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
    titleView.titleLabel.text = coin.name
    titleView.subtitleLabel.text =  coin.symbol
    navigationItem.titleView = titleView
    sparklineDataStrings = coin.sparkline
  }

  private func setupDetailInfo(){
    let maxValue = sparklineData.max() ?? 0
    let minValue = sparklineData.min() ?? 0
    highLabel.text = "\(maxValue.formattedPrice(decimalCount: 2))"
    lowLabel.text = "\(minValue.formattedPrice(decimalCount: 2))"
  }

  private func convertSparklineData() {
    for stringData in sparklineDataStrings {
      if let doubleValue = Double(stringData) {
        sparklineData.append(doubleValue)
      }
    }
  }

}
