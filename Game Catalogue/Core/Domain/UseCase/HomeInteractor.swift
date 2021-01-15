//
//  HomeInteractor.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 12/01/21.
//

import Foundation

protocol HomeUseCase {

  func getGameList(completion: @escaping (Result<[GameModel], Error>) -> Void)

}

class HomeInteractor: HomeUseCase {

  private let repository: GameRepositoryProtocol

  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }

  func getGameList(
    completion: @escaping (Result<[GameModel], Error>) -> Void
  ) {
    repository.getGameList { result in
      completion(result)
    }
  }

}
