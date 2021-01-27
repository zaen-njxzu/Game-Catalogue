//
//  SearchCatalogueRemoteSource.swift
//  
//
//  Created by Zaenal Arsy on 26/01/21.
//

import Foundation
import CoreSDK
import Combine
import Alamofire

public struct SearchCatalogueRemoteSource: DataSource {
  public typealias Request = String
  public typealias Response = [GameResponse]
  private let _endpoint: String
  public init(endpoint: String) {
      _endpoint = endpoint
  }
  public func execute(request: String?) -> AnyPublisher<[GameResponse], Error> {
      return Future<[GameResponse], Error> { completion in
        if let request = request {
          let params: Parameters = [
            "search": request
          ]
          if let url = URL(string: _endpoint) {
            AF.request(url, method: .get, parameters: params)
              .validate()
              .responseDecodable(of: CatalogueResponse.self) { response in
                switch response.result {
                case .success(let value):
                  completion(.success(value.results))
                case .failure:
                  completion(.failure(URLError.invalidResponse))
                }
              }
          }
        } else {
          completion(.failure(URLError.invalidParameter))
        }
      }.eraseToAnyPublisher()
  }
}
