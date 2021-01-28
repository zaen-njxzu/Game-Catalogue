//
//  FavouriteCatalogueRepository.swift
//  
//
//  Created by Zaenal Arsy on 27/01/21.
//

import CoreSDK
import Combine

public struct FavouriteCatalogueRepository<
  FavouriteLocalDataSource: LocalDataSource,
  Transformer: Mapper>: Repository
where
  FavouriteLocalDataSource.Response == CatalogueModelEntity,
  FavouriteLocalDataSource.Request == Int,
  Transformer.Response == [GameResponse],
  Transformer.Entity == [CatalogueModelEntity],
  Transformer.Domain == [CatalogueDomainModel] {
  public typealias Request = Int
  public typealias Response = [CatalogueDomainModel]
  private let _localDataSource: FavouriteLocalDataSource
  private let _mapper: Transformer
  public init(
    localDataSource: FavouriteLocalDataSource,
    mapper: Transformer) {
    _localDataSource = localDataSource
    _mapper = mapper
  }
  public func execute(request: Int?) -> AnyPublisher<[CatalogueDomainModel], Error> {
    return _localDataSource.get()
      .map { _mapper.transformEntityToDomain(entity: $0) }
      .eraseToAnyPublisher()
  }
}
