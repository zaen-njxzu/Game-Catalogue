//
//  GetDetailCatalogueRemoteDataSource.swift
//  
//
//  Created by Zaenal Arsy on 28/01/21.
//

import Foundation
import CoreSDK
import Combine
import Alamofire

public struct GetDetailCatalogueRemoteDataSource: DataSource {
  public typealias Request = Int
  public typealias Response = DetailCatalogueResponse
  private let _endpoint: String
  public init(endpoint: String) {
    _endpoint = endpoint
  }
  public func execute(request: Int?) -> AnyPublisher<DetailCatalogueResponse, Error> {
    return Future<DetailCatalogueResponse, Error> { completion in
      guard let request = request else { return completion(.failure(URLError.invalidParameter))}
      if let url = URL(string: "\(_endpoint)\(request)") {
        AF.request(url, method: .get)
          .validate()
          .responseDecodable(of: DetailCatalogueResponse.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
}
