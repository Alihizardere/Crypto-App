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
    backgroundColor = .purple
    layer.borderWidth = 2
    layer.borderColor =  UIColor.systemGray.cgColor
    layer.cornerRadius = 10
  }

}