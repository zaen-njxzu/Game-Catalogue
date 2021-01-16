//
//  DetailInteractor.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 12/01/21.
//

import Foundation
import Combine

protocol DetailUseCase {

  func getDetailGame(with id: Int) -> AnyPublisher<DetailGameModel, Error>
  func updateFavoriteGame(by gameId: Int) -> AnyPublisher<GameModel, Error>
}

class DetailInteractor: DetailUseCase {

  private let repository: GameRepositoryProtocol

  required init(
    repository: GameRepositoryProtocol
  ) {
    self.repository = repository
  }

  func getDetailGame(with id: Int) -> AnyPublisher<DetailGameModel, Error> {
    repository.getDetailGame(with: id)
  }
  func updateFavoriteGame(by gameId: Int) -> AnyPublisher<GameModel, Error> {
    repository.updateFavoriteGame(by: gameId)
  }

}
