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

}

final class GameRepository: NSObject {

    typealias GameInstance = (RemoteDataSource) -> GameRepository

    fileprivate let remote: RemoteDataSource

    private init(remote: RemoteDataSource) {
        self.remote = remote
    }

    static let sharedInstance: GameInstance = { remoteRepo in
        return GameRepository(remote: remoteRepo)
    }

}

extension GameRepository: GameRepositoryProtocol {
    
    func getDetailGame(with id: Int, result: @escaping (Result<DetailGameModel, Error>) -> Void) {
        self.remote.getDetailGame(with: id) { (remoteResponse) in
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
