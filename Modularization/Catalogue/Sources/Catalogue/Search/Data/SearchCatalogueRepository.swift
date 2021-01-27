//
//  SearchCatalogueRepository.swift
//  
//
//  Created by Zaenal Arsy on 26/01/21.
//

import CoreSDK
import Combine

public struct SearchCatalogueRepository<
  RemoteDataSource: DataSource,
  Transformer: Mapper>: Repository
where
  RemoteDataSource.Response == [GameResponse],
  Transformer.Response == [GameResponse],
  Transformer.Entity == [CatalogueModelEntity],
  Transformer.Domain == [CatalogueDomainModel] {
  public typealias Request = String
  public typealias Response = [CatalogueDomainModel]
  private let _remoteDataSource: RemoteDataSource
  private let _mapper: Transformer
  public init(
    remoteDataSource: RemoteDataSource,
    mapper: Transformer) {
    _remoteDataSource = remoteDataSource
    _mapper = mapper
  }
  public func execute(request: String?) -> AnyPublisher<[CatalogueDomainModel], Error> {
    return _remoteDataSource.execute(request: request as? RemoteDataSource.Request)
      .map { _mapper.transformResponseToDomain(response: $0) }
      .eraseToAnyPublisher()
  }
}
