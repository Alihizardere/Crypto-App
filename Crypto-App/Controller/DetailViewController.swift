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

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    guard let coin = selectedCoin else { return }
    print(coin.symbol)
  }

}
