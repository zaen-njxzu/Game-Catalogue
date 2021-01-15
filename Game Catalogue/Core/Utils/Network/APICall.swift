//
//  APICall.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 11/01/21.
//

import Foundation

struct API {

  static let baseUrl = "https://api.rawg.io/api/"

}

protocol Endpoint {

  var url: String { get }

}

enum Endpoints {
  enum Gets: Endpoint {
    case gameList
    case detailGame
    public var url: String {
      switch self {
      case .gameList: return "\(API.baseUrl)games"
      case .detailGame: return "\(API.baseUrl)games/"
      }
    }
  }
}
