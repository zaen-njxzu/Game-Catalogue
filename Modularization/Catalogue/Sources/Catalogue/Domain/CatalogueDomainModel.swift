//
//  CatalogueDomainModel.swift
//
//
//  Created by Zaenal Arsy on 25/01/21.
//

import Foundation

public struct CatalogueDomainModel: Equatable, Identifiable {
  public let id: Int
  public let name: String
  public let releasedAt: String
  public let imageUrl: String
  public let rating: String
  public let favourite: Bool
  
  public init(id: Int, name: String, releasedAt: String, imageUrl: String, rating: String, favourite: Bool) {
    self.id = id
    self.name = name
    self.releasedAt = releasedAt
    self.imageUrl = imageUrl
    self.rating = rating
    self.favourite = favourite
  }
}
