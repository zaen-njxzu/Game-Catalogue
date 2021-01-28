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
  @ObservedObject var presenter: CataloguePresenter
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
            self.presenter.linkBuilder(for: game) {
              GameRow(game: game)
            }.buttonStyle(PlainButtonStyle())
          }.padding(8)
        }
      }
    }
  }
}

extension GetListPresenter {

  fileprivate func linkBuilder<Content: View>(
    for game: CatalogueDomainModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: HomeRouter().makeDetailView(for: game)) { content() }
  }
}
