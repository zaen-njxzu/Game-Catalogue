//
//  SearchInteractor.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 18/01/21.
//

import Foundation
import Combine

protocol SearchUseCase {
  func searchGames(query: String) -> AnyPublisher<[GameModel], Error>
}

class SearchInteractor: SearchUseCase {

  private let repository: GameRepositoryProtocol

  required init(
    repository: GameRepositoryProtocol
  ) {
    self.repository = repository
  }
  func searchGames(query: String) -> AnyPublisher<[GameModel], Error> {
    repository.searchGames(query: query)
  }

}
