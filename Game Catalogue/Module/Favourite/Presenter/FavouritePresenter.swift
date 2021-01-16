//
//  FavouritePresenter.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 16/01/21.
//

import SwiftUI
import Combine

class FavouritePresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
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
    favouriteUseCase.getFavouriteGames()
      .subscribe(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.loadingState = false
        case .finished:
          self.loadingState = false
        }
      } receiveValue: { games in
        self.games = games
      }
  }
  func favouriteGame(game: GameModel, completion: @escaping (Bool, AlertOneMessage) -> Void) {
    favouriteUseCase.updateFavoriteGame(by: game.id)
      .subscribe(on: RunLoop.main)
      .sink { _completion in
        switch _completion {
        case .failure(let error):
          completion(false, AlertOneMessage(title: "Fail!", message: "Failed to delete \(game.name), because  \(error.localizedDescription)", buttonText: "OK"))
        case .finished: break
        }
      } receiveValue: { game in
        completion(true, AlertOneMessage(title: "Success!", message: "You already delete \(game.name) on favourite games.", buttonText: "OK"))
      }
      .store(in: &cancellables)
  }
  func linkBuilder<Content: View>(
    for game: GameModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: router.makeDetailView(for: game)) { content() }
  }
}
