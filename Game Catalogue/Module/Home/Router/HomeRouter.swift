//
//  HomeRouter.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 12/01/21.
//

import SwiftUI
import Catalogue

class HomeRouter {
  func makeDetailView(for game: CatalogueDomainModel) -> some View {
    return DetailView(presenter: Injection.init().provideDetailPresenter(catalogue: game))
  }
}
