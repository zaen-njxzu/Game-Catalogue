//
//  DetailPresenter.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 12/01/21.
//

import SwiftUI
import Combine

class DetailPresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let detailUseCase: DetailUseCase
  var game: GameModel

  @Published var detailGame: DetailGameModel?
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false

  init(game: GameModel, detailUseCase: DetailUseCase) {
    self.detailUseCase = detailUseCase
    self.game = game
  }
  func getDetailGame() {
    loadingState = true
    detailUseCase.getDetailGame(with: game.id)
      .subscribe(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.loadingState = false
        case .finished:
          self.loadingState = false
        }
      } receiveValue: { detailGame in
        self.detailGame = detailGame
      }
      .store(in: &cancellables)
  }
  func favouriteGame(completion: @escaping (AlertOneMessage) -> Void) {
    detailUseCase.updateFavoriteGame(by: game.id)
      .subscribe(on: RunLoop.main)
      .sink { _completion in
        switch _completion {
        case .failure(let error):
          completion(AlertOneMessage(title: "Fail!", message: error.localizedDescription, buttonText: "OK"))
        case .finished: break
        }
      } receiveValue: { game in
        completion(AlertOneMessage(title: "Success!", message: game.favourite ? "\(game.name) saved into favourite games" : "\(game.name) is being removed from favourite games", buttonText: "OK"))
        self.game = game
      }
      .store(in: &cancellables)
  }

}
