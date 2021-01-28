//
//  CatalogueResponse.swift
//  
//
//  Created by Zaenal Arsy on 25/01/21.
//

import Foundation
import CoreSDK

public struct CatalogueResponse: Codable {
  let results: [GameResponse]
}

public struct GameResponse: Codable {
  let id: Int
  let name, rating: String
  let backgroundImage, released: String?

  enum CodingKeys: String, CodingKey {
    case id, name, released, rating
    case backgroundImage = "background_image"
  }
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    id = try container.decode(Int.self, forKey: .id)
    name = try container.decode(String.self, forKey: .name)
    backgroundImage = try container.decode(String?.self, forKey: .backgroundImage)
    let ratingDouble = try container.decode(Double.self, forKey: .rating)
    rating = "\(ratingDouble)/5"
    let releasedDate = try container.decode(String?.self, forKey: .released)
    if let safeReleasedDate = releasedDate {
      released = safeReleasedDate.toDate(from: "yyyy-MM-dd", to: "dd MMMM yyyy", with: safeReleasedDate)
    } else {
      released = ""
    }
  }
}
