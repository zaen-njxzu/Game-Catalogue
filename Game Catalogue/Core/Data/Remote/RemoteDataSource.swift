//
//  RemoteDataSource.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 11/01/21.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: class {
  func getGames() -> AnyPublisher<[GameResponse], Error>
  func getDetailGame(with id: Int) -> AnyPublisher<DetailGameResponse, Error>
  func searchGames(query: String) -> AnyPublisher<[GameResponse], Error>
}

final class RemoteDataSource: NSObject {

  private override init() { }

  static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {
  func getDetailGame(with id: Int) -> AnyPublisher<DetailGameResponse, Error> {
    return Future<DetailGameResponse, Error> { completion in
      if let url = URL(string: "\(Endpoints.Gets.detailGame.url)\(id)") {
        AF.request(url, method: .get)
          .validate()
          .responseDecodable(of: DetailGameResponse.self) { response in
            switch response.result {
            case .success(let value): completion(.success(value))
            case .failure: completion(.failure(URLError.invalidResponse))
            }
        }
      }
    }.eraseToAnyPublisher()
  }
  func getGames() -> AnyPublisher<[GameResponse], Error> {
    return Future<[GameResponse], Error> { completion in
      if let url = URL(string: Endpoints.Gets.gameList.url) {
        AF.request(url, method: .get)
          .validate()
          .responseDecodable(of: GamesResponse.self) { response in
            switch response.result {
            case .success(let value): completion(.success(value.results))
            case .failure: completion(.failure(URLError.invalidResponse))
            }
        }
      }
    }.eraseToAnyPublisher()
  }
  func searchGames(query: String) -> AnyPublisher<[GameResponse], Error> {
    return Future<[GameResponse], Error> { completion in
      let params: Parameters = [
        "search": query
      ]
      if let url = URL(string: Endpoints.Gets.searchGame.url) {
        AF.request(url, method: .get, parameters: params)
          .validate()
          .responseDecodable(of: GamesResponse.self) { response in
            switch response.result {
            case .success(let value):
              print(value)
              completion(.success(value.results))
            case .failure: completion(.failure(URLError.invalidResponse))
            }
        }
      }
    }.eraseToAnyPublisher()
  }
}
