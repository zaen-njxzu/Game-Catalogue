//
//  FavouriteRouter.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 16/01/21.
//

import SwiftUI
import Catalogue

class FavouriteRouter {
  func makeDetailView(for game: CatalogueDomainModel) -> some View {
    return DetailView(presenter: Injection.init().provideDetailPresenter(catalogue: game))
  }
}
