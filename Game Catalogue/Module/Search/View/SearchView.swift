//
//  SearchView.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 18/01/21.
//

import SwiftUI

struct SearchView: View {
  @ObservedObject var presenter: SearchPresenter

  var body: some View {
    VStack {
      SearchBar(
        text: $presenter.query,
        onSearchButtonClicked: presenter.searchGames
      )
      ZStack {
        Color(UIColor.Ext.Blue)
        if presenter.loadingState {
          loadingIndicator
        } else {
          if presenter.errorMessage != "" {
            Text(presenter.errorMessage)
              .foregroundColor(.white)
              .font(.largeTitle)
          } else if presenter.games.isEmpty {
            Text("Empty Search")
              .foregroundColor(.white)
              .font(.largeTitle)
          } else {
            gameScrollList
          }
        }
      }

    }
  }
}

extension SearchView {
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
