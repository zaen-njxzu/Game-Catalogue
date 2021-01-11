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
              VStack {
                Text("Loading...")
                    .bold()
                    .foregroundColor(.white)
                ActivityIndicator()
              }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(
                        self.presenter.games,
                        id: \.id
                    ) { game in
                        ZStack {
                            GameRow(game: game)
//                            self.presenter.linkBuilder(for: game) {
//                                GameRow(game: game)
//                            }.buttonStyle(PlainButtonStyle())
                        }.padding(8)
                    }
                }
            }

        }
        .onAppear() {
            if self.presenter.games.count == 0 {
                self.presenter.getGameList()
            }
        }
        .navigationBarTitle(
          Text("Games List"),
            displayMode: .inline
        )
        .navigationBarItems(trailing:
            NavigationLink(
                destination: ProfileView(),
                label: {
                    Image(systemName: "person.fill")
                        .foregroundColor(.white)
                })
        )
        .background(NavigationConfigurator { nc in
            nc.navigationBar.barTintColor = UIColor.Ext.DarkBlue
            nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        })
        .navigationViewStyle(StackNavigationViewStyle())

        
    }
}

