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
  @IBOutlet weak var symbolLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var changeLabel: UILabel!
  @IBOutlet weak var cardView: UIView!
  var color: String?

  // MARK: - Lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
    cardView.addShadow()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  // MARK: - Functions
  func configure(coin: Coin){
    self.nameLabel.text = coin.name
    self.symbolLabel.text = coin.symbol
    priceLabel.text = "$\(Double(coin.price)?.formattedPrice(decimalCount: 5) ?? "0.0")"
    self.changeLabel.text = "\(coin.change)%"

    let iconUrlString = coin.iconUrl.replacingOccurrences(of: "svg", with: "png")
    guard let iconUrl = URL(string: iconUrlString) else { return }
    self.coinImageView.kf.setImage(with: iconUrl)

    color = coin.color
    cardView.layer.borderWidth = 2
    cardView.layer.borderColor = UIColor(hex: color ?? "white").cgColor
  }
}
