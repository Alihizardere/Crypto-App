//
//  CoinLogicProtocol.swift
//  Crypto-App
//
//  Created by alihizardere on 4.05.2024.
//

import Foundation

protocol CoinLogicProtocol {
  func getAllCoins(completionHandler: @escaping (Result<CoinResponse, Error>) -> Void)
}
