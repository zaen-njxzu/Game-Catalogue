//
//  GetCatalogueRepository.swift
//  
//
//  Created by Zaenal Arsy on 25/01/21.
//

import CoreSDK
import Combine

public struct GetCatalogueRepository<
  CatalogueLocalDataSource: LocalDataSource,
  RemoteDataSource: DataSource,
  Transformer: Mapper>: Repository
where
  CatalogueLocalDataSource.Response == CatalogueModelEntity,
  RemoteDataSource.Response == [GameResponse],
  Transformer.Response == [GameResponse],
  Transformer.Entity == [CatalogueModelEntity],
  Transformer.Domain == [CatalogueDomainModel] {
  public typealias Request = Any
  public typealias Response = [CatalogueDomainModel]
  private let _localDataSource: CatalogueLocalDataSource
  private let _remoteDataSource: RemoteDataSource
  private let _mapper: Transformer
  public init(
    localDataSource: CatalogueLocalDataSource,
    remoteDataSource: RemoteDataSource,
    mapper: Transformer) {
    
    _localDataSource = localDataSource
    _remoteDataSource = remoteDataSource
    _mapper = mapper
  }
  public func execute(request: Any?) -> AnyPublisher<[CatalogueDomainModel], Error> {
    return _localDataSource.get()
      .flatMap { result -> AnyPublisher<[CatalogueDomainModel], Error> in
        if result.isEmpty {
          return _remoteDataSource.execute(request: nil)
            .map { _mapper.transformResponseToEntity(response: $0) }
            .catch { _ in _localDataSource.get() }
            .flatMap { _localDataSource.add(from: $0) }
            .filter { $0 }
            .flatMap { _ in _localDataSource.get()
              .map { _mapper.transformEntityToDomain(entity: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return _localDataSource.get()
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
}
