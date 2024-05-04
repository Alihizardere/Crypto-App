//
//  CoinCell.swift
//  Crypto-App
//
//  Created by alihizardere on 4.05.2024.
//

import UIKit

class CoinCell: UITableViewCell {

  static let identifier = "CoinCell"
  @IBOutlet weak var coinImageView: UIImageView!
  @IBOutlet weak var symbolLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var changeLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  func configure(coin: Coin){
    self.nameLabel.text = coin.name
    self.symbolLabel.text = coin.symbol
    self.priceLabel.text = coin.price
    self.changeLabel.text = coin.change
  }
}
