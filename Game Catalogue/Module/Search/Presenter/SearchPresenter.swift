//
//  SearchPresenter.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 18/01/21.
//

import SwiftUI
import Combine

class SearchPresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let router = SearchRouter()
  private let searchUseCase: SearchUseCase

  @Published var games: [GameModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  var query = ""

  init(searchUseCase: SearchUseCase) {
    self.searchUseCase = searchUseCase
  }
  func searchGames() {
    loadingState = true
    searchUseCase.searchGames(query: query)
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
      .store(in: &cancellables)

  }
  func linkBuilder<Content: View>(
    for game: GameModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: router.makeDetailView(for: game)) { content() }
  }

}
