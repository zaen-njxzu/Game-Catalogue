//
//  HomeView.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 10/01/21.
//

import SwiftUI

struct HomeView: View {
  @ObservedObject var presenter: HomePresenter

  var body: some View {
    ZStack {
      Color(UIColor.Ext.Blue)
      if presenter.loadingState {
        loadingIndicator
      } else {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                gameList
            }.padding(8)
        }
      }
    }
    .onAppear {
      if self.presenter.games.count == 0 {
        self.presenter.getGameList()
      }
    }
  }
}

extension HomeView {
  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
        .bold()
        .foregroundColor(.white)
      ActivityIndicator()
    }
  }
  var gameList: some View {
    ForEach(
      self.presenter.games,
      id: \.id
    ) { game in
      ZStack {
        self.presenter.linkBuilder(for: game) {
          GameRow(game: game)
        }.buttonStyle(PlainButtonStyle())
      }.padding(8)
    }
  }
}