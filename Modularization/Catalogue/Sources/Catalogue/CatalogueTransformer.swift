//
//  CatalogueTransformer.swift
//  
//
//  Created by Zaenal Arsy on 25/01/21.
//

import Foundation
import CoreSDK

public struct CatalogueTransformer: Mapper {

  public typealias Response = [GameResponse]
  public typealias Entity = [CatalogueModelEntity]
  public typealias Domain = [CatalogueDomainModel]
  public init() {}

  public func transformDomainToEntity(domain: [CatalogueDomainModel]) -> [CatalogueModelEntity] {
    fatalError()
  }
  public func transformResponseToDomain(response: [GameResponse]) -> [CatalogueDomainModel] {
    return response.map { result in
      CatalogueDomainModel(
        id: result.id,
        name: result.name,
        releasedAt: result.released ?? "",
        imageUrl: result.backgroundImage ?? "",
        rating: result.rating,
        favourite: false
      )
    }
  }
  public func transformResponseToEntity(response: [GameResponse]) -> [CatalogueModelEntity] {
    return response.map { result in
      let newCatalogue = CatalogueModelEntity()
      newCatalogue.id = result.id
      newCatalogue.name = result.name
      newCatalogue.released = result.released ?? ""
      newCatalogue.backgroundImage = result.backgroundImage ?? ""
      newCatalogue.rating = result.rating
      newCatalogue.favourite = false
      return newCatalogue
    }
  }
  public func transformEntityToDomain(entity: [CatalogueModelEntity]) -> [CatalogueDomainModel] {
    return entity.map { result in
      CatalogueDomainModel(
        id: result.id,
        name: result.name,
        releasedAt: result.released,
        imageUrl: result.backgroundImage,
        rating: result.rating,
        favourite: result.favourite
      )
    }
  }
}

public struct SingleCatalogueTransformer: Mapper {
  public typealias Response = GameResponse
  public typealias Entity = CatalogueModelEntity
  public typealias Domain = CatalogueDomainModel
  public init() {}

  public func transformDomainToEntity(domain: CatalogueDomainModel) -> CatalogueModelEntity {
    let newCatalogue = CatalogueModelEntity()
    newCatalogue.id = domain.id
    newCatalogue.name = domain.name
    newCatalogue.released = domain.releasedAt
    newCatalogue.backgroundImage = domain.imageUrl
    newCatalogue.rating = domain.rating
    newCatalogue.favourite = false
    return newCatalogue
  }
  public func transformResponseToDomain(response: GameResponse) -> CatalogueDomainModel {
    CatalogueDomainModel(
      id: response.id,
      name: response.name,
      releasedAt: response.released ?? "",
      imageUrl: response.backgroundImage ?? "",
      rating: response.rating,
      favourite: false
    )
  }
  public func transformResponseToEntity(response: GameResponse) -> CatalogueModelEntity {
    let newCatalogue = CatalogueModelEntity()
    newCatalogue.id = response.id
    newCatalogue.name = response.name
    newCatalogue.released = response.released ?? ""
    newCatalogue.backgroundImage = response.backgroundImage ?? ""
    newCatalogue.rating = response.rating
    newCatalogue.favourite = false
    return newCatalogue
  }
  public func transformEntityToDomain(entity: CatalogueModelEntity) -> CatalogueDomainModel {
    CatalogueDomainModel(
      id: entity.id,
      name: entity.name,
      releasedAt: entity.released,
      imageUrl: entity.backgroundImage,
      rating: entity.rating,
      favourite: entity.favourite
    )
  }
}
