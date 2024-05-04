//
//  Router.swift
//  Crypto-App
//
//  Created by alihizardere on 4.05.2024.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {

  case allCoins

  var method: HTTPMethod {
    switch self {
    case .allCoins:
      return .get
    }
  }

  var parameters: [String: Any]? {
    switch self {
    case .allCoins:
      return nil
    }
  }

  var encoding: ParameterEncoding {
    JSONEncoding.default
  }

  var url: URL {
    switch self {
    case .allCoins:
      let url = URL(string: Constants.coinURL)
      return url!
    }
  }

  func asURLRequest() throws -> URLRequest {
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    return try encoding.encode(urlRequest, with: parameters)
  }
}
