//
//  FavouriteView.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 16/01/21.
//

import SwiftUI
import Catalogue

struct FavouriteView: View {
  @ObservedObject var presenter: FavouriteCataloguePresenterAlias
  @State var dragOffset = CGSize.zero
  @State var currentId = 0
  @State var showingAlert = false
  @State var alertMessage: AlertOneMessage = AlertOneMessage()
  var body: some View {
    ZStack {
      Color(UIColor.Ext.Blue)
      if presenter.isLoading {
        loadingIndicator
      } else {
        if presenter.list.isEmpty {
          VStack {
            Text("Empty Data")
              .foregroundColor(.white)
              .font(.largeTitle)
          }
        } else {
          gameScrollList
        }
      }
    }
    .onAppear {
      self.dragOffset = .zero
      self.currentId = 0
      self.presenter.getFavouriteCatalogue()
      self.alertMessage = AlertOneMessage()
      self.showingAlert = false
    }
    .alert(isPresented: $showingAlert) {
      Alert(title: Text(alertMessage.title), message: Text(alertMessage.message), dismissButton: .default(Text(alertMessage.buttonText)))
    }
  }

}

extension FavouriteView {
  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
        .bold()
        .foregroundColor(.white)
      ActivityIndicator()
    }
  }
  @available(iOS 14.0, *)
  var gameScrollList: some View {
    ScrollView {
      LazyVStack(spacing: 0) {
        ForEach(
          self.presenter.list,
          id: \.id
        ) { game in
          ZStack {
            self.presenter.linkBuilder(for: game) {
              gameRowDragable(for: game)
            }.buttonStyle(PlainButtonStyle())
          }.padding(8)
        }
      }
    }
  }
  func gameRowDragable(for game: CatalogueDomainModel) -> some View {
    GameRow(game: game)
      .animation(.spring())
      .offset(offset(for: game.id))
      .gesture(
        DragGesture()
          .onChanged({ value in
            self.currentId = game.id
            self.dragOffset = value.translation
          })
          .onEnded({ value in
            let width = value.translation.width
            if abs(width) > 100 {
              let x = width > 0 ? 1000 : -1000
              self.dragOffset = .init(width: x, height: 0)
              self.presenter.favouriteCatalogue(catalogue: game) { (isSuccess, catalogue) in
                if isSuccess {
                  self.presenter.list.removeAll { result in
                    result.id == game.id
                  }
                  self.alertMessage = AlertOneMessage(title: "Success!", message: catalogue.favourite == true ? "\(catalogue.name) favourited!" : "\(catalogue.name) deleted from favourites!", buttonText: "OK")
                } else {
                  self.alertMessage = AlertOneMessage(title: "Failed!", message: catalogue.favourite == true ? "\(catalogue.name) fail to favourited!" : "\(catalogue.name) fail to delete from favourites!", buttonText: "OK")
                }
                self.showingAlert = true
              }
            } else {
              self.dragOffset = .zero
            }
          })
      )
  }
  func offset(for id: Int) -> CGSize {
      return id == currentId ? dragOffset : .zero
  }

}

extension FavouriteCataloguePresenter {
  func linkBuilder<Content: View>(
    for game: CatalogueDomainModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: FavouriteRouter().makeDetailView(for: game)) { content() }
  }
}
