//
//  FavouriteView.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 16/01/21.
//

import SwiftUI

struct FavouriteView: View {
  @ObservedObject var presenter: FavouritePresenter
  @State var dragOffset = CGSize.zero
  @State var currentId = 0
  @State var showingAlert = false
  @State var alertMessage: AlertOneMessage = AlertOneMessage()
  var body: some View {
    ZStack {
      Color(UIColor.Ext.Blue)
      if presenter.loadingState {
        loadingIndicator
      } else {
        if presenter.games.isEmpty {
          VStack {
            Text("Empty Data")
              .foregroundColor(.white)
              .font(.largeTitle)
          }
        } else {
          ScrollView(.vertical, showsIndicators: false) {
              VStack {
                  gameList
              }.padding(8)
          }
        }
      }
    }
    .onAppear {
      self.dragOffset = .zero
      self.currentId = 0
      self.presenter.getGames()
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
  var gameList: some View {
    ForEach(
      self.presenter.games,
      id: \.id
    ) { game in
      ZStack {
        self.presenter.linkBuilder(for: game) {
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
                    self.presenter.favouriteGame(game: game) { (isSuccess, alert) in
                      if isSuccess {
                        self.presenter.games.removeAll { result in
                          result.id == game.id
                        }
                      }
                      self.alertMessage = alert
                      self.showingAlert = true
                    }
                  } else {
                    self.dragOffset = .zero
                  }
                })
            )
        }.buttonStyle(PlainButtonStyle())
      }.padding(8)
    }
  }
  func offset(for id: Int) -> CGSize {
      return id == currentId ? dragOffset : .zero
  }

}
