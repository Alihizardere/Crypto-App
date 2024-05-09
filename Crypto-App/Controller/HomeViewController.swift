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
  @IBOutlet weak var headerTableView: UIView!
  let filterList = ["Price", "24h Vol", "Market Cap", "Change", "List Order"]
  var viewModel = HomeViewModel()
  var selectedIndex: IndexPath?

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    fetchData()
  }

  func fetchData() {
    viewModel.getAllCoins { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success:
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      case .failure(let error):
        print("\(error.localizedDescription)")
      }
    }
  }

  private func setupUI(){
    // MARK: - TableView
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: CoinCell.identifier, bundle: nil), forCellReuseIdentifier: CoinCell.identifier)
    tableView.showsVerticalScrollIndicator = false
    headerTableView.layer.cornerRadius = 20
    headerTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

    // MARK: - CollectionView
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UINib(nibName: RankingCell.identifier, bundle: nil), forCellWithReuseIdentifier: RankingCell.identifier)

    // MARK: - Background Color
    let startPoint = CGPoint(x: 0, y: 0)
    let endPoint = CGPoint(x: 1, y: 1)
    view.setBackgroundGradient(colors: [.systemBlue.withAlphaComponent(0.7), .purple.withAlphaComponent(0.8)], startPoint: startPoint, endPoint: endPoint)

    // MARK: - Navbar
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true;
  }
}

// MARK: - TableView Protocols
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.coins.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier, for: indexPath) as! CoinCell
    let coin = viewModel.coins[indexPath.row]
    cell.configure(coin: coin)
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let coin = viewModel.coins[indexPath.row]
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
    
    if let previousIndex = selectedIndex {
      if let previousCell = collectionView.cellForItem(at: previousIndex) as? RankingCell {
        previousCell.contentView.backgroundColor = .clear
        previousCell.rankLabel.textColor = .black
      }
    }
    
    if let selectedCell = collectionView.cellForItem(at: indexPath) as? RankingCell{
      selectedCell.contentView.backgroundColor = #colorLiteral(red: 0.024102984, green: 0.1555764675, blue: 0.4802163243, alpha: 1)
      selectedCell.rankLabel.textColor = .white
    }

    let selectedFilter = filterList[indexPath.row]

    switch selectedFilter {
    case  "Price":
      viewModel.coins.sort { Double($0.price) ?? 0 > Double($1.price) ?? 0 }
    case "24h Vol":
      viewModel.coins.sort { Int($0.the24HVolume) ?? 0 > Int($1.the24HVolume) ?? 0 }
    case "Market Cap":
      viewModel.coins.sort { Int($0.marketCap) ?? 0 > Int($1.marketCap) ?? 0 }
    case "Change":
      viewModel.coins.sort { Double($0.change) ?? 0 > Double($1.change) ?? 0 }
    case "List Order":
      viewModel.coins.sort{$0.listedAt < $1.listedAt}
    default:
      break
    }

    tableView.reloadData()
    selectedIndex = indexPath
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
