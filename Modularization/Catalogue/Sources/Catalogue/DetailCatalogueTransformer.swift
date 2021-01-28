//
//  DetailCatalogueTransformer.swift
//  
//
//  Created by Zaenal Arsy on 28/01/21.
//

import Foundation
import CoreSDK

public struct SingleDetailCatalogueTransformer: Mapper {
  public typealias Response = DetailCatalogueResponse
  public typealias Entity = Any
  public typealias Domain = DetailCatalogueDomainModel
  public init() {}

  public func transformDomainToEntity(domain: DetailCatalogueDomainModel) -> Any {
    fatalError()
  }
  public func transformResponseToDomain(response: DetailCatalogueResponse) -> DetailCatalogueDomainModel {
    return DetailCatalogueDomainModel(
      id: response.id,
      name: response.name,
      description: response.descriptionRaw,
      imageUrl: response.backgroundImage,
      releasedAt: response.released,
      rating: response.rating
    )
  }
  public func transformResponseToEntity(response: DetailCatalogueResponse) -> Any {
    fatalError()
  }
  public func transformEntityToDomain(entity: Any) -> DetailCatalogueDomainModel {
    fatalError()
  }
}
