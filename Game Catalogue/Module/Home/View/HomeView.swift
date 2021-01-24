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
        if presenter.errorMessage != "" {
          Text(presenter.errorMessage)
            .foregroundColor(.white)
            .font(.largeTitle)
        } else {
          gameScrollList
        }
      }
    }
    .onAppear {
      self.presenter.getGames()
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
  var gameScrollList: some View {
    ScrollView {
      LazyVStack(spacing: 0) {
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
  }
}
