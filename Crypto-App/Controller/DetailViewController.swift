//
//  DetailViewController.swift
//  Crypto-App
//
//  Created by alihizardere on 6.05.2024.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

  // MARK: - Properties
  var selectedCoin: Coin?
  var sparklineDataStrings = [String]()
  var sparklineData: [Double] = []
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var highLabel: UILabel!
  @IBOutlet weak var lowLabel: UILabel!
  @IBOutlet weak var marketCapLabel: UILabel!
  @IBOutlet weak var volumeLabel: UILabel!
  @IBOutlet weak var changeButton: UIButton!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var chartView: ChartView!
  @IBOutlet weak var staticsView: UIView!
  @IBOutlet weak var websiteButton: UIButton!
  @IBOutlet weak var buyButton: UIButton!

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSelectedCoin()
    setupUI()
    convertSparklineData()
    setupDetailInfo()
    chartView.sparklineData = sparklineData
  }

  // MARK: - Functions
  private func setupUI() {
    navigationController?.navigationBar.tintColor = .white
    containerView.layer.cornerRadius = 40
    containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

    let startPoint = CGPoint(x: 0, y: 0)
    let endPoint = CGPoint(x: 1, y: 1)
    view.setBackgroundGradient(colors: [.systemBlue.withAlphaComponent(0.7), .purple.withAlphaComponent(0.8)], startPoint: startPoint, endPoint: endPoint)

    staticsView.setBackgroundGradient(colors: [.blue.withAlphaComponent(0.2), .systemBlue.withAlphaComponent(0.4)], startPoint:startPoint, endPoint: endPoint)
    staticsView.layer.cornerRadius = 20
    staticsView.clipsToBounds = true

    buyButton.layer.borderWidth = 2
    buyButton.layer.borderColor = UIColor(named: "thirdColor")?.cgColor
    websiteButton.setTitle("", for: .normal)
    websiteButton.setImage(UIImage(named: "websiteIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
    websiteButton.tintColor = .third
  }

  private func setupSelectedCoin(){
    guard let coin = selectedCoin else { return }

    guard let price = Double(coin.price),
          let changeValue = Double(coin.change),
          let marketCap = Double(coin.marketCap),
          let volume = Double(coin.the24HVolume) else {
      return
    }
    priceLabel.text = "$\(price.formattedPrice(decimalCount: 5))"
    changeButton.setTitle("\(coin.change)%", for: .normal)
    marketCapLabel.text = "$\(marketCap.formattedPrice(decimalCount: 0))"
    volumeLabel.text = "$\(volume.formattedPrice(decimalCount: 0))"
    changeButton.backgroundColor = changeValue < 0 ? UIColor(named: "customRed") : UIColor(named: "customGreen")

    let titleView = NavbarTitleView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
    titleView.titleLabel.text = coin.name
    titleView.subtitleLabel.text =  coin.symbol
    navigationItem.titleView = titleView
    sparklineDataStrings = coin.sparkline
  }

  private func setupDetailInfo(){
    let maxValue = sparklineData.max() ?? 0
    let minValue = sparklineData.min() ?? 0
    highLabel.text = "$\(maxValue.formattedPrice(decimalCount: 2))"
    lowLabel.text = "$\(minValue.formattedPrice(decimalCount: 2))"
  }

  private func convertSparklineData() {
    for stringData in sparklineDataStrings {
      if let doubleValue = Double(stringData) {
        sparklineData.append(doubleValue)
      }
    }
  }
  
  // MARK: - Actions
  @IBAction func visitWebsiteButton(_ sender: UIButton) {
    guard let url = selectedCoin?.coinrankingUrl else { return }
    let customWebView = WebView(frame: UIScreen.main.bounds)
    customWebView.webUrl = url
    customWebView.navigationController = self.navigationController
    customWebView.tabbarController = self.tabBarController
    navigationController?.setNavigationBarHidden(true, animated: true)
    tabBarController?.tabBar.isHidden = true
    view.addSubview(customWebView)
  }
}
