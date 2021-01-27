//
//  SearchView.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 18/01/21.
//

import SwiftUI
import CoreSDK
import Catalogue

struct SearchView: View {
  @ObservedObject var presenter: SearchCataloguePresenter
  @State private var query = ""

  var body: some View {
    VStack {
      SearchBar(
        text: $query,
        onSearchButtonClicked: {
          presenter.getList(request: query)
        }
      )
      ZStack {
        Color(UIColor.Ext.Blue)
        if presenter.isLoading {
          loadingIndicator
        } else {
          if presenter.errorMessage != "" {
            Text(presenter.errorMessage)
              .foregroundColor(.white)
              .font(.largeTitle)
          } else if presenter.list.isEmpty {
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
          self.presenter.list,
          id: \.id
        ) { game in
          ZStack {
            self.presenter.linkBuilder(for: GameMapper.mapCatalogueDomainToGameDomain(input: game)) {
              GameRow(game: GameMapper.mapCatalogueDomainToGameDomain(input: game))
            }.buttonStyle(PlainButtonStyle())
          }.padding(8)
        }
      }
    }
  }
}

extension GetListPresenter {
  fileprivate func linkBuilder<Content: View>(
    for game: GameModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: SearchRouter().makeDetailView(for: game)) { content() }
  }
}
