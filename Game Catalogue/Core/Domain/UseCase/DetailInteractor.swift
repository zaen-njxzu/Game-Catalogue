//
//  DetailInteractor.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 12/01/21.
//

import Foundation

protocol DetailUseCase {

  func getDetailGame(with id: Int, completion: @escaping (Result<DetailGameModel, Error>) -> Void)
  func addGame(
    from games: GameModel,
    completion: ((Result<Bool, Error>) -> Void)?
  )
}

class DetailInteractor: DetailUseCase {

  private let repository: GameRepositoryProtocol

  required init(
    repository: GameRepositoryProtocol
  ) {
    self.repository = repository
  }

  func getDetailGame(
    with id: Int,
    completion: @escaping (Result<DetailGameModel, Error>) -> Void
  ) {
    repository.getDetailGame(with: id) { result in
      completion(result)
    }
  }
  func addGame(from game: GameModel, completion: ((Result<Bool, Error>) -> Void)? = nil) {
    repository.addGame(from: game) { result in
      completion?(result)
    }
  }

}
