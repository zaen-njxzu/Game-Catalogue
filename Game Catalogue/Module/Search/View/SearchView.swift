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
//  @ObservedObject var presenter: SearchPresenter
  @ObservedObject var presenter: GetListPresenter<String, CatalogueDomainModel, Interactor<String, [CatalogueDomainModel], SearchCatalogueRepository<SearchCatalogueRemoteSource, CatalogueTransformer>>>
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
