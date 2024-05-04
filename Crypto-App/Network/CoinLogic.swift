//
//  CoinLogic.swift
//  Crypto-App
//
//  Created by alihizardere on 4.05.2024.
//

import Foundation

final class CoinLogic: CoinLogicProtocol {

  static let shared: CoinLogic = {
    let instance = CoinLogic()
    return instance
  }()

  private init() {}

  func getAllCoins(completionHandler: @escaping (Result<CoinResponse, any Error>) -> Void) {
    <#code#>
  }
}
