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
  @IBOutlet weak var collectionView: UICollectionView!
  var coins = [Coin]()
  let filterList = ["Price", "24h Vol", "Market Cap", "Change", "List Order"]

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.showsVerticalScrollIndicator = false
    navigationController?.navigationBar.shadowImage = UIImage()
    tableView.register(UINib(nibName: CoinCell.identifier, bundle: nil), forCellReuseIdentifier: CoinCell.identifier)

    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UINib(nibName: RankingCell.identifier, bundle: nil), forCellWithReuseIdentifier: RankingCell.identifier)

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

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let coin = coins[indexPath.row]
    performSegue(withIdentifier: "toDetail", sender: coin)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toDetail" {
      let destinationVC = segue.destination as! DetailViewController
      guard let coin = sender as? Coin  else { return }
      destinationVC.selectedCoin = coin
    }
  }
}

// MARK: - CollectionView Protocols
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    filterList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RankingCell.identifier, for: indexPath) as! RankingCell
    cell.rankLabel.text = filterList[indexPath.row]
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    let selectedFilter = filterList[indexPath.row]

    switch selectedFilter {
    case  "Price":
      coins.sort{$0.price < $1.price}
    case "24h Vol":
      coins.sort{ $0.the24HVolume < $1.the24HVolume }
    case "Market Cap":
      coins.sort{$0.marketCap < $1.marketCap}
    case "Change":
      coins.sort{$0.change < $1.change}
    case "List Order":
      coins.sort{$0.listedAt < $1.listedAt}
    default:
      break
    }
    tableView.reloadData()
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let filterName = filterList[indexPath.item]
    let label = UILabel()
    label.text = filterName
    label.sizeToFit()

    let cellWidth = label.frame.width + 20
    let cellHeight = collectionView.frame.height 
    return CGSize(width: cellWidth, height: cellHeight)
  }
}
