//
//  FavouriteInteractor.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 16/01/21.
//

import Foundation

protocol FavouriteUseCase {

  func getGames(completion: @escaping (Result<[GameModel], Error>) -> Void)
  func deleteGame(
    with gameId: Int,
    completion: ((Result<Bool, Error>) -> Void)?
  )
}

class FavouriteInteractor: FavouriteUseCase {

  private let repository: GameRepositoryProtocol

  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }

  func getGames(completion: @escaping (Result<[GameModel], Error>) -> Void) {
    repository.getGames { result in
      completion(result)
    }
  }
  func deleteGame(with gameId: Int, completion: ((Result<Bool, Error>) -> Void)? = nil) {
    repository.deleteGame(with: gameId) { result in
      completion?(result)
    }
  }

}
