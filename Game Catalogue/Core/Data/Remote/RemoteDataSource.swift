//
//  RemoteDataSource.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 11/01/21.
//

import Foundation
import Alamofire

protocol RemoteDataSourceProtocol: class {

  func getGameList(result: @escaping (Result<[GameResponse], URLError>) -> Void)
  func getDetailGame(with id: Int, result: @escaping (Result<DetailGameResponse, URLError>) -> Void)

}

final class RemoteDataSource: NSObject {

  private override init() { }

  static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {
  func getDetailGame(with id: Int, result: @escaping (Result<DetailGameResponse, URLError>) -> Void) {
    guard let url = URL(string: "\(Endpoints.Gets.detailGame.url)\(id)") else { return }
    AF.request(url, method: .get)
      .validate()
      .responseDecodable(of: DetailGameResponse.self) { response in
        switch response.result {
        case .success(let value): result(.success(value))
        case .failure: result(.failure(.invalidResponse))
        }
    }
  }
  func getGameList(result: @escaping (Result<[GameResponse], URLError>) -> Void) {
    guard let url = URL(string: Endpoints.Gets.gameList.url) else { return }

    AF.request(url, method: .get)
      .validate()
      .responseDecodable(of: GamesResponse.self) { response in
        switch response.result {
        case .success(let value): result(.success(value.results))
        case .failure: result(.failure(.invalidResponse))
        }
    }
  }
}
