//
//  DetailCatalogueDomainModel.swift
//  
//
//  Created by Zaenal Arsy on 28/01/21.
//

import Foundation

public struct DetailCatalogueDomainModel: Equatable, Identifiable {
  public let id: Int
  public let name: String
  public let description: String
  public let imageUrl: String
  public let releasedAt: String
  public let rating: String
  public init(id: Int, name: String, description: String, imageUrl: String, releasedAt: String, rating: String) {
    self.id = id
    self.name = name
    self.description = description
    self.imageUrl = imageUrl
    self.releasedAt = releasedAt
    self.rating = rating
  }
}
