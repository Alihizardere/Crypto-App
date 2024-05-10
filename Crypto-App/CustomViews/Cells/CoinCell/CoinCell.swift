//
//  CoinCell.swift
//  Crypto-App
//
//  Created by alihizardere on 4.05.2024.
//

import UIKit
import Kingfisher

class CoinCell: UITableViewCell {

  // MARK: - Properties
  static let identifier = "CoinCell"
  @IBOutlet weak var coinImageView: UIImageView!
  @IBOutlet weak var shadowView: UIView!
  @IBOutlet weak var symbolLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var changePercent: UILabel!
  @IBOutlet weak var changePrice: UILabel!
  @IBOutlet weak var cardView: UIView!

  // MARK: - Lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  // MARK: - Functions
  func configure(coin: Coin){
    nameLabel.text = coin.name
    symbolLabel.text = coin.symbol
    changePercent.text = "\(coin.change)%"

    // MARK: - Format operations
    if let doublePrice = Double(coin.price) {
      let formattedPrice = doublePrice.formattedPrice(decimalCount: 5)
      priceLabel.text = "$\(formattedPrice)"

      var changeValue: Double = 0.0
      if let changePercent = Double(coin.change) {
        changeValue = doublePrice * changePercent / 100
      }
      let formattedChangePrice = changeValue.formattedPrice(decimalCount: 4)
      changePrice.text = "$\(formattedChangePrice)"

      let changeColor = changeValue < 0 ? UIColor(named: "customRed") : UIColor(named: "customGreen")
      changePercent.textColor = changeColor
      changePrice.textColor = changeColor
    }
    
    // MARK: - Image Setup
    let iconUrlString = coin.iconUrl.replacingOccurrences(of: "svg", with: "png")
    guard let iconUrl = URL(string: iconUrlString) else { return }
    coinImageView.kf.setImage(with: iconUrl)
    shadowView.backgroundColor = UIColor(hex: coin.color ?? "#fff").withAlphaComponent(0.3)
    shadowView.layer.cornerRadius = 30
    cardView.addShadow()
  }
}
