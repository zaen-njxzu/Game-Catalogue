//
//  GameRepository.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 11/01/21.
//

import Foundation

protocol GameRepositoryProtocol {

  func getDetailGame(with id: Int, result: @escaping (Result<DetailGameModel, Error>) -> Void)
  func getGameList(result: @escaping (Result<[GameModel], Error>) -> Void)
  func getGames(result: @escaping (Result<[GameModel], Error>) -> Void)
  func addGame(
    from game: GameModel,
    result: @escaping (Result<Bool, Error>) -> Void
  )
  func deleteGame(
    with id: Int,
    result: @escaping (Result<Bool, Error>) -> Void
  )

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
  func getGames(result: @escaping (Result<[GameModel], Error>) -> Void) {
    self.local.getGames { localResponse in
      switch localResponse {
      case .success(let gameEntities):
        result(.success(GameMapper.mapGameEntitiesToDomains(input: gameEntities)))
      case .failure(let error):
        result(.failure(error))
      }
    }
  }
  func addGame(from game: GameModel, result: @escaping (Result<Bool, Error>) -> Void) {
    self.local.addGame(from: GameMapper.mapGameDomainToEntity(input: game)) { localResponse in
      switch localResponse {
      case .success(let isSuccess):
        result(.success(isSuccess))
      case .failure(let error):
        result(.failure(error))
      }
    }
  }
  func deleteGame(with id: Int, result: @escaping (Result<Bool, Error>) -> Void) {
    self.local.deleteGame(with: id) { localResponse in
      switch localResponse {
      case .success(let isSuccess):
        result(.success(isSuccess))
      case .failure(let error):
        result(.failure(error))
      }
    }
  }
  func getDetailGame(with gameId: Int, result: @escaping (Result<DetailGameModel, Error>) -> Void) {
    self.remote.getDetailGame(with: gameId) { (remoteResponse) in
      switch remoteResponse {
      case .success(let detailGameResponse):
        result(.success(GameMapper.mapDetailGameResponseToDomain(input: detailGameResponse)))
      case .failure(let error):
        result(.failure(error))
      }
    }
  }
  func getGameList(
      result: @escaping (Result<[GameModel], Error>) -> Void
  ) {
    self.remote.getGameList { (remoteResponses) in
      switch remoteResponses {
      case .success(let gameResponse):
        let resultList = GameMapper.mapGameResponseToDomain(input: gameResponse)
        result(.success(resultList))
      case .failure(let error):
        result(.failure(error))
      }
    }
  }
}
