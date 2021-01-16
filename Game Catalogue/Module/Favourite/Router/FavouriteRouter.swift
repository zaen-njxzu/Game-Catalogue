//
//  FavouriteRouter.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 16/01/21.
//

import SwiftUI

class FavouriteRouter {
  func makeDetailView(for game: GameModel) -> some View {
    let detailUseCase = Injection.init().provideDetail()
    let presenter = DetailPresenter(game: game, detailUseCase: detailUseCase)
    return DetailView(presenter: presenter)
  }
}
