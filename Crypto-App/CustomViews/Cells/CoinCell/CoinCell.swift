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
  @IBOutlet weak var changeLabel: UILabel!
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
    priceLabel.text = "$\(Double(coin.price)?.formattedPrice(decimalCount: 5) ?? "0.0")"
    changeLabel.text = "\(coin.change)%"
    guard let changeValue = Double(coin.change) else  {
      changeLabel.textColor = .black
      return
    }
    changeLabel.textColor = changeValue < 0 ? .red : .green

    let iconUrlString = coin.iconUrl.replacingOccurrences(of: "svg", with: "png")
    guard let iconUrl = URL(string: iconUrlString) else { return }
    coinImageView.kf.setImage(with: iconUrl)
    shadowView.backgroundColor = UIColor(hex: coin.color ?? "#fff").withAlphaComponent(0.3)
    shadowView.layer.cornerRadius = 30
    cardView.addShadow()
  }

  private func colorForChange(change: String) -> UIColor {
    guard let changeValue = Double(change) else { return .black }
    return changeValue < 0 ? .red :  .green
  }
}
