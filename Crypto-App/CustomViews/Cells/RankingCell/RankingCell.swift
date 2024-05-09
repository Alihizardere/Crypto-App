//
//  RankingCell.swift
//  Crypto-App
//
//  Created by alihizardere on 6.05.2024.
//

import UIKit

class RankingCell: UICollectionViewCell {

  // MARK: - Properties
  static let identifier = "RankingCell"
  @IBOutlet weak var rankLabel: UILabel!

  // MARK: - Lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
    layer.borderWidth = 1
    layer.borderColor =  UIColor.white.cgColor
    layer.cornerRadius = 10
  }

}
