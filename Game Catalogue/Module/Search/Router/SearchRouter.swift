//
//  SearchRouter.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 18/01/21.
//

import SwiftUI
import Catalogue

class SearchRouter {
  func makeDetailView(for game: CatalogueDomainModel) -> some View {
    return DetailView(presenter: Injection.init().provideDetailPresenter(catalogue: game))
  }
}
