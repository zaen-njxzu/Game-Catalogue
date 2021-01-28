//
//  ModifyFavouriteCatalogueRepository.swift
//  
//
//  Created by Zaenal Arsy on 27/01/21.
//

import CoreSDK
import Combine

public struct ModifyFavouriteCatalogueRepository<
  FavouriteLocalDataSource: LocalDataSource,
  Transformer: Mapper>: Repository
where
  FavouriteLocalDataSource.Response == CatalogueModelEntity,
  FavouriteLocalDataSource.Request == Int,
  Transformer.Response == GameResponse,
  Transformer.Entity == CatalogueModelEntity,
  Transformer.Domain == CatalogueDomainModel {
  public typealias Request = CatalogueDomainModel
  public typealias Response = CatalogueDomainModel
  private let _localDataSource: FavouriteLocalDataSource
  private let _mapper: Transformer
  public init(
    localDataSource: FavouriteLocalDataSource,
    mapper: Transformer) {
    _localDataSource = localDataSource
    _mapper = mapper
  }
  public func execute(request: CatalogueDomainModel?) -> AnyPublisher<CatalogueDomainModel, Error> {
    return _localDataSource.set(by: request?.id)
      .map { _mapper.transformEntityToDomain(entity: $0) }
      .tryCatch({ _ -> AnyPublisher<CatalogueDomainModel, Error> in
        var catalogueEntities: [CatalogueModelEntity] = []
        if let request = request {
          catalogueEntities.append(_mapper.transformDomainToEntity(domain: request))
        }
        return _localDataSource.add(from: catalogueEntities)
          .filter { $0 }
        .flatMap { _ in _localDataSource.set(by: request?.id)
          .map { _mapper.transformEntityToDomain(entity: $0) }
        }
        .eraseToAnyPublisher()
      })
      .eraseToAnyPublisher()
  }
}
