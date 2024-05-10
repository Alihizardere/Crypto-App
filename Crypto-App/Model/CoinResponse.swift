//
//  CoinResponse.swift
//  Crypto-App
//
//  Created by alihizardere on 4.05.2024.
//

import Foundation

struct CoinResponse: Decodable {
  let status: String
  let data: CoinResults
}

struct CoinResults: Decodable {
  let coins: [Coin]
}

struct Coin: Decodable {
  let uuid, symbol, name: String
  let color: String?
  let iconUrl: String
  let marketCap, price, change: String
  let listedAt, tier, rank: Int
  let sparkline: [String]
  let lowVolume: Bool
  let coinrankingUrl: String
  let the24HVolume, btcPrice: String

  enum CodingKeys: String, CodingKey {
    case uuid, symbol, name
    case color, iconUrl
    case marketCap, price, change
    case listedAt, tier, rank
    case sparkline, lowVolume, coinrankingUrl, btcPrice
    case the24HVolume = "24hVolume"
  }
}
