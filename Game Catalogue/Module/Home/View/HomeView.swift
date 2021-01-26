//
//  HomeView.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 10/01/21.
//

import SwiftUI
import Catalogue
import CoreSDK

struct HomeView: View {
  @ObservedObject var presenter: GetListPresenter<Any, CatalogueDomainModel, Interactor<Any, [CatalogueDomainModel], GetCatalogueRepository<GetCatalogueLocalDataSource, GetCatalogueRemoteDataSource, CatalogueTransformer>>>
  var body: some View {
    ZStack {
      Color(UIColor.Ext.Blue)
      if presenter.isLoading {
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
      self.presenter.getList(request: nil)
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

  func linkBuilder<Content: View>(
    for game: GameModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: HomeRouter().makeDetailView(for: game)) { content() }
  }
}
