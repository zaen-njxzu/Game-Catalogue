//
//  ContentView.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 10/01/21.
//

import SwiftUI
import Catalogue
import CoreSDK

struct ContentView: View {
  let homePresenter: GetListPresenter<String, CatalogueDomainModel, Interactor<String, [CatalogueDomainModel], GetCatalogueRepository<GetCatalogueLocalDataSource, GetCatalogueRemoteDataSource, CatalogueTransformer>>>
  let searchPresenter: GetListPresenter<String, CatalogueDomainModel, Interactor<String, [CatalogueDomainModel], SearchCatalogueRepository<SearchCatalogueRemoteSource, CatalogueTransformer>>>
  let favouritePresenter: FavouriteCataloguePresenterAlias
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
        SearchView(presenter: searchPresenter)
          .tabItem {
            Image(systemName: "magnifyingglass")
            Text("Search Games")
          }
          .tag(Tabs.tabSearch)
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
      .navigationViewStyle(StackNavigationViewStyle())
    }
  }
  enum Tabs {
    case tabHome, tabProfile, tabFavourite, tabSearch
    var title: String {
      switch self {
      case .tabHome: return "Games List"
      case .tabProfile: return "My Profile"
      case .tabFavourite: return "Favourite Games"
      case .tabSearch: return "Search Games"
      }
    }
  }
}
