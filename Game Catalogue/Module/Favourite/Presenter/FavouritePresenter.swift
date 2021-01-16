//
//  FavouritePresenter.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 16/01/21.
//

import SwiftUI

class FavouritePresenter: ObservableObject {

  private let router = FavouriteRouter()
  private let favouriteUseCase: FavouriteUseCase

  @Published var games: [GameModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false

  init(favouriteUseCase: FavouriteUseCase) {
    self.favouriteUseCase = favouriteUseCase
  }
  func getGames() {
    loadingState = true
    favouriteUseCase.getGames { result in
      switch result {
      case .success(let games):
        DispatchQueue.main.async {
          self.loadingState = false
          self.games = games
        }
      case .failure(let error):
        DispatchQueue.main.async {
          self.loadingState = false
          self.errorMessage = error.localizedDescription
        }
      }
    }
  }
  func deleteGame(game: GameModel, completion: @escaping (Bool, AlertOneMessage) -> Void) {
    favouriteUseCase.deleteGame(with: game.id) { result in
      switch result {
      case .success:
        completion(true, AlertOneMessage(title: "Success!", message: "You already delete \(game.name) on favourite games.", buttonText: "OK"))
      case .failure(let error):
        completion(false, AlertOneMessage(title: "Fail!", message: "Failed to delete \(game.name), because  \(error.localizedDescription)", buttonText: "OK"))
      }
    }
  }
  func linkBuilder<Content: View>(
    for game: GameModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: router.makeDetailView(for: game)) { content() }
  }
}
