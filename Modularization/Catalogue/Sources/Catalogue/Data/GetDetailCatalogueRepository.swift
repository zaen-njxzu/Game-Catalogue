//
//  GetDetailCatalogueRepository.swift
//  
//
//  Created by Zaenal Arsy on 28/01/21.
//

import CoreSDK
import Combine

public struct GetDetailCatalogueRepository<
  RemoteDataSource: DataSource,
  Transformer: Mapper>: Repository
where
RemoteDataSource.Response == DetailCatalogueResponse,
RemoteDataSource.Request == Int,
Transformer.Response == DetailCatalogueResponse,
Transformer.Domain == DetailCatalogueDomainModel {
  public typealias Request = Int
  public typealias Response = DetailCatalogueDomainModel
  private let _remoteDataSource: RemoteDataSource
  private let _mapper: Transformer
  public init(
    remoteDataSource: RemoteDataSource,
    mapper: Transformer) {
    _remoteDataSource = remoteDataSource
    _mapper = mapper
  }
  public func execute(request: Int?) -> AnyPublisher<DetailCatalogueDomainModel, Error> {
    return _remoteDataSource.execute(request: request)
      .map { _mapper.transformResponseToDomain(response: $0) }
      .eraseToAnyPublisher()
  }
}
