//
//  HomePresenter.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 12/01/21.
//

import SwiftUI

class HomePresenter: ObservableObject {

    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase

    @Published var games: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false

    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
  
    func getGameList() {
        loadingState = true
        homeUseCase.getGameList { result in
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
  
//  func linkBuilder<Content: View>(
//    for game: GameModel,
//    @ViewBuilder content: () -> Content
//  ) -> some View {
//    NavigationLink(
//    destination: router.makeDetailView(for: game)) { content() }
//  }

}
