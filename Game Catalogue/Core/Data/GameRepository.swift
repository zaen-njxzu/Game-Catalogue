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
  func updateFavoriteGame(by gameId: Int) -> AnyPublisher<GameModel, Error>
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
  func getGames() -> AnyPublisher<[GameModel], Error> {
    return self.local.getGames()
      .flatMap { result -> AnyPublisher<[GameModel], Error> in
        if result.isEmpty {
          return self.remote.getGames()
            .map { GameMapper.mapGameResponsesToEntiies(input: $0) }
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
  func updateFavoriteGame(by gameId: Int) -> AnyPublisher<GameModel, Error> {
    return self.local.updateFavoriteGame(by: gameId)
      .map { GameMapper.mapGameEntityToDomain(input: $0) }
      .eraseToAnyPublisher()
  }
}
