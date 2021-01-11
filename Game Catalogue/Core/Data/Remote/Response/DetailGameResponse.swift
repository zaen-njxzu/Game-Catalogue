//
//  DetailGameResponse.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 11/01/21.
//

import Foundation

struct DetailGameResponse: Codable {
    let id: Int
    let released, name, backgroundImage, descriptionRaw: String
    let rating: String

    enum CodingKeys: String, CodingKey {
        case name, released, rating, id
        case descriptionRaw = "description_raw"
        case backgroundImage = "background_image"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        backgroundImage = try container.decode(String.self, forKey: .backgroundImage)
        descriptionRaw = try container.decode(String.self, forKey: .descriptionRaw)
        
        let ratingDouble = try container.decode(Double.self, forKey: .rating)
        rating = "\(ratingDouble)/5"
        
        let releasedDate = try container.decode(String.self, forKey: .released)
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let showDate = inputFormatter.date(from: releasedDate)
        inputFormatter.dateFormat = "dd MMMM yyyy"
        let resultString = inputFormatter.string(from: showDate!)
        
        released = resultString
    }
}
