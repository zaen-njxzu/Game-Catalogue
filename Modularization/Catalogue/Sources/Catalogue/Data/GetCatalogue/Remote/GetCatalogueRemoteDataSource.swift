//
//  GetCatalogueRemoteDataSource.swift
//  
//
//  Created by Zaenal Arsy on 25/01/21.
//

import CoreSDK
import Combine
import Alamofire
import Foundation

public struct GetCatalogueRemoteDataSource : DataSource {
  public typealias Request = String
  public typealias Response = [GameResponse]
  private let _endpoint: String
  public init(endpoint: String) {
      _endpoint = endpoint
  }
  public func execute(request: String?) -> AnyPublisher<[GameResponse], Error> {
      return Future<[GameResponse], Error> { completion in
        if let url = URL(string: _endpoint) {
          AF.request(url)
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
      }.eraseToAnyPublisher()
  }
}
