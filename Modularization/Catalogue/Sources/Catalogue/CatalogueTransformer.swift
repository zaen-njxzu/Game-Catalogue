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
