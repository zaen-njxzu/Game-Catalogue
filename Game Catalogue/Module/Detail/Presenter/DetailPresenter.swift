//
//  DetailPresenter.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 12/01/21.
//

import SwiftUI

class DetailPresenter: ObservableObject {

  private let detailUseCase: DetailUseCase
  private let game: GameModel

  @Published var detailGame: DetailGameModel?
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false

  init(game: GameModel, detailUseCase: DetailUseCase) {
    self.detailUseCase = detailUseCase
    self.game = game
  }
  func getDetailGame() {
    loadingState = true
    detailUseCase.getDetailGame(with: game.id) { (result) in
      switch result {
      case .success(let detail):
        print(detail)
        DispatchQueue.main.async {
          self.loadingState = false
          self.detailGame = detail
        }
      case .failure(let error):
        print(error)
        DispatchQueue.main.async {
          self.loadingState = false
          self.errorMessage = error.localizedDescription
        }
      }
    }
  }
  func favouriteGame(completion: @escaping (AlertOneMessage) -> Void) {
    detailUseCase.addGame(from: self.game) { result in
      switch result {
      case .success:
        completion(AlertOneMessage(title: "Success!", message: "Game already saved.", buttonText: "OK"))
      case .failure(let error):
        completion(AlertOneMessage(title: "Fail!", message: error.localizedDescription, buttonText: "OK"))
      }
    }
  }

}
