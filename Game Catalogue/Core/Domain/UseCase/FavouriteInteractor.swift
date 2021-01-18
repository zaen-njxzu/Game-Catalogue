//
//  FavouriteInteractor.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 16/01/21.
//

import Foundation
import Combine

protocol FavouriteUseCase {

  func getFavouriteGames() -> AnyPublisher<[GameModel], Error>
  func updateFavoriteGame(by game: GameModel) -> AnyPublisher<GameModel, Error>

}

class FavouriteInteractor: FavouriteUseCase {

  private let repository: GameRepositoryProtocol

  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }

  func getFavouriteGames() -> AnyPublisher<[GameModel], Error> {
    repository.getFavouriteGames()
  }

  func updateFavoriteGame(by game: GameModel) -> AnyPublisher<GameModel, Error> {
    repository.updateFavoriteGame(by: game)
  }

}
