//
//  HomeRouter.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 12/01/21.
//

import SwiftUI

class HomeRouter {

  func makeDetailView(for gameId: Int) -> some View {
    let detailUseCase = Injection.init().provideDetail()
    let presenter = DetailPresenter(id: gameId, detailUseCase: detailUseCase)
    return DetailView(presenter: presenter)
  }
  
}
