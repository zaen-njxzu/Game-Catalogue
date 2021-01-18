//
//  GameRepository.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 11/01/21.
//

import Foundation
import Combine

protocol GameRepositoryProtocol {
  func getGames() -> AnyPublisher<[GameModel], Error>
  func getDetailGame(with id: Int) -> AnyPublisher<DetailGameModel, Error>
  func getFavouriteGames() -> AnyPublisher<[GameModel], Error>
  func updateFavoriteGame(by game: GameModel) -> AnyPublisher<GameModel, Error>
  func searchGames(query: String) -> AnyPublisher<[GameModel], Error>
}

final class GameRepository: NSObject {

  typealias GameInstance = (RemoteDataSource, LocalDataSource) -> GameRepository

  fileprivate let remote: RemoteDataSource
  fileprivate let local: LocalDataSource

  private init(remote: RemoteDataSource, local: LocalDataSource) {
    self.remote = remote
    self.local = local
  }

  static let sharedInstance: GameInstance = { remoteRepo, localRepo  in
    return GameRepository(remote: remoteRepo, local: localRepo)
  }

}

extension GameRepository: GameRepositoryProtocol {
  func searchGames(query: String) -> AnyPublisher<[GameModel], Error> {
    return self.remote.searchGames(query: query)
      .map { GameMapper.mapGameResponsesToDomain(input: $0) }
      .eraseToAnyPublisher()
  }
  func getGames() -> AnyPublisher<[GameModel], Error> {
    return self.local.getGames()
      .flatMap { result -> AnyPublisher<[GameModel], Error> in
        if result.isEmpty {
          return self.remote.getGames()
            .map { GameMapper.mapGameResponsesToEntities(input: $0) }
            .catch { _ in self.local.getGames() }
            .flatMap { self.local.addGames(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.local.getGames()
              .map { GameMapper.mapGameEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.local.getGames()
            .map { GameMapper.mapGameEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
  func getDetailGame(with id: Int) -> AnyPublisher<DetailGameModel, Error> {
    return self.remote.getDetailGame(with: id)
      .map { GameMapper.mapDetailGameResponseToDomain(input: $0) }
      .eraseToAnyPublisher()
  }
  func getFavouriteGames() -> AnyPublisher<[GameModel], Error> {
    return self.local.getFavouriteGames()
      .map { GameMapper.mapGameEntitiesToDomains(input: $0) }
      .eraseToAnyPublisher()
  }
  func updateFavoriteGame(by game: GameModel) -> AnyPublisher<GameModel, Error> {
    return self.local.updateFavoriteGame(by: game.id)
      .map { GameMapper.mapGameEntityToDomain(input: $0) }
      .tryCatch({ _ -> AnyPublisher<GameModel, Error> in
        let games: [GameModel] = [game]
        return self.local.addGames(from: GameMapper.mapGamesDomainToEntities(input: games))
          .filter { $0 }
          .flatMap { _ in self.local.updateFavoriteGame(by: game.id)
            .map { GameMapper.mapGameEntityToDomain(input: $0) }
          }
          .eraseToAnyPublisher()
      })
      .eraseToAnyPublisher()
  }
}
