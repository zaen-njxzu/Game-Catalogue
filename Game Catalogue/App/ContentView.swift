//
//  ContentView.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 10/01/21.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var homePresenter: HomePresenter
  @EnvironmentObject var favouritePresenter: FavouritePresenter
  @State var tabSelection: Tabs = .tabHome

  var body: some View {
    NavigationView {
      TabView(selection: $tabSelection) {
        HomeView(presenter: homePresenter)
        .tabItem {
          Image(systemName: "gamecontroller.fill")
          Text("Games List")
        }
        .tag(Tabs.tabHome)
        FavouriteView(presenter: favouritePresenter)
          .tabItem {
            Image(systemName: "heart.fill")
            Text("Favourite Games")
          }
          .tag(Tabs.tabFavourite)
        ProfileView()
          .tabItem {
            Image(systemName: "person.circle.fill")
            Text("My Profile")
          }
          .tag(Tabs.tabProfile)
      }
      .navigationBarTitle(
        Text(tabSelection.title),
        displayMode: .inline
      )
      .background(NavigationConfigurator { navController in
        navController.navigationBar.barTintColor = UIColor.Ext.DarkBlue
        navController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
      })
      .navigationViewStyle(StackNavigationViewStyle())
    }
  }
  enum Tabs {
    case tabHome, tabProfile, tabFavourite
    var title: String {
      switch self {
      case .tabHome: return "Games List"
      case .tabProfile: return "My Profile"
      case .tabFavourite: return "Favourite Games"
      }
    }
  }
}
