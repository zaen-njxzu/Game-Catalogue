//
//  DetailInteractor.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 12/01/21.
//

import Foundation

protocol DetailUseCase {

  func getDetailGame(with id: Int, completion: @escaping (Result<DetailGameModel, Error>) -> Void)

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

}
