//
//  GameMapper.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 12/01/21.
//

import Foundation

final class GameMapper {
    
    static func mapGameResponseToDomain(
      input resultResponses: [GameResponse]
    ) -> [GameModel] {

      return resultResponses.map { result in
        return GameModel(
            id: result.id,
            name: result.name,
            releasedAt: result.released,
            imageUrl: result.backgroundImage,
            rating: result.rating
        )
      }
    }
    
    static func mapDetailGameResponseToDomain(
      input detailGameResponse: DetailGameResponse
    ) -> DetailGameModel {

      return DetailGameModel(
        id: detailGameResponse.id,
        name: detailGameResponse.name,
        description: detailGameResponse.descriptionRaw,
        imageUrl: detailGameResponse.backgroundImage,
        releasedAt: detailGameResponse.released,
        rating: detailGameResponse.rating
      )
    }

    
}
