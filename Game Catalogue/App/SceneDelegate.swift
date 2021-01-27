//
//  SceneDelegate.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 10/01/21.
//

import UIKit
import SwiftUI
import CoreSDK
import Catalogue

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  func scene(
      _ scene: UIScene,
      willConnectTo session: UISceneSession,
      options connectionOptions: UIScene.ConnectionOptions
  ) {

    let homePresenter = CataloguePresenter(useCase: Injection.init().provideCatalogue())
    let searchPresenter = SearchCataloguePresenter(useCase: Injection.init().provideSearchCatalogue())
    let favouritePresenter = FavouritePresenter(favouriteUseCase: Injection.init().provideFavourite())
    
    let contentView = ContentView(homePresenter: homePresenter, searchPresenter: searchPresenter, favouritePresenter: favouritePresenter)

    if let windowScene = scene as? UIWindowScene {
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: contentView)
        self.window = window
        window.makeKeyAndVisible()
    }
  }

}
