//
//  HomeViewModel.swift
//  Crypto-App
//
//  Created by alihizardere on 9.05.2024.
//

import Foundation

class HomeViewModel {
    var coins: [Coin] = []

    func getAllCoins(completion: @escaping (Result<[Coin], Error>) -> Void) {
        CoinLogic.shared.getAllCoins { result in
            switch result {
            case .success(let data):
                self.coins = data.data.coins
                completion(.success(data.data.coins))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
