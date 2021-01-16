//
//  HomeInteractor.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 12/01/21.
//

import Foundation
import Combine

protocol HomeUseCase {

  func getGames() -> AnyPublisher<[GameModel], Error>

}

class HomeInteractor: HomeUseCase {

  private let repository: GameRepositoryProtocol

  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }
  func getGames() -> AnyPublisher<[GameModel], Error> {
    repository.getGames()
  }

}
