//
//  ViewController.swift
//  Crypto-App
//
//  Created by alihizardere on 4.05.2024.
//

import UIKit

class HomeViewController: UIViewController {
  // MARK: - Properties
  @IBOutlet weak var tableView: UITableView!
  var coins = [Coin]()

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: CoinCell.identifier, bundle: nil), forCellReuseIdentifier: CoinCell.identifier)

    CoinLogic.shared.getAllCoins { [weak self] result in
      guard let self else { return }
      switch result {
      case .success(let data):
        self.coins = data.data.coins
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      case .failure(let error):
        print("\(error.localizedDescription)")
      }
    }
  }
}

// MARK: - TableView Protocols
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    coins.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier, for: indexPath) as! CoinCell
    let coin = coins[indexPath.row]
    cell.configure(coin: coin)
    return cell
  }
}

