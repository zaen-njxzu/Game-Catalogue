//
//  GameMapper.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 12/01/21.
//

import Foundation

final class GameMapper {
  static func mapGamesDomainToEntities(
    input games: [GameModel]
  ) -> [GameEntity] {
    return games.map { result in
      let newGame = GameEntity()
      newGame.id = result.id
      newGame.name = result.name
      newGame.released = result.releasedAt
      newGame.backgroundImage = result.imageUrl
      newGame.rating = result.rating
      newGame.favourite = false
      return newGame
    }
  }
  static func mapGameResponsesToDomain(
    input games: [GameResponse]
  ) -> [GameModel] {
    return games.map { result in
      return GameModel(
        id: result.id,
        name: result.name,
        releasedAt: result.released ?? "",
        imageUrl: result.backgroundImage ?? "",
        rating: result.rating,
        favourite: false
      )
    }
  }
  static func mapGameResponsesToEntities(
    input games: [GameResponse]
  ) -> [GameEntity] {
    return games.map { result in
      let newGame = GameEntity()
      newGame.id = result.id
      newGame.name = result.name
      newGame.released = result.released ?? ""
      newGame.backgroundImage = result.backgroundImage ?? ""
      newGame.rating = result.rating
      newGame.favourite = false
      return newGame
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
  static func mapGameEntityToDomain(
    input game: GameEntity
  ) -> GameModel {
    GameModel(
      id: game.id,
      name: game.name,
      releasedAt: game.released,
      imageUrl: game.backgroundImage,
      rating: game.rating,
      favourite: game.favourite
    )
  }
  static func mapGameEntitiesToDomains(
    input gameEntities: [GameEntity]
  ) -> [GameModel] {
    return gameEntities.map { result in
      GameModel(
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
