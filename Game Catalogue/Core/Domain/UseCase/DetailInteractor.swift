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
    private let game: GameModel

    required init(
        repository: GameRepositoryProtocol,
        game: GameModel
    ) {
        self.repository = repository
        self.game = game
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
