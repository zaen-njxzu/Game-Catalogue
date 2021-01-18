//
//  SceneDelegate.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 10/01/21.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  func scene(
      _ scene: UIScene,
      willConnectTo session: UISceneSession,
      options connectionOptions: UIScene.ConnectionOptions
  ) {
    let homeUseCase = Injection.init().provideHome()
    let favouriteUseCase = Injection.init().provideFavourite()
    let searchUseCase = Injection.init().provideSearch()
    let homePresenter = HomePresenter(homeUseCase: homeUseCase)
    let favouritePresenter = FavouritePresenter(favouriteUseCase: favouriteUseCase)
    let searchPresenter = SearchPresenter(searchUseCase: searchUseCase)
    let contentView = ContentView()
      .environmentObject(homePresenter)
      .environmentObject(favouritePresenter)
      .environmentObject(searchPresenter)

    if let windowScene = scene as? UIWindowScene {
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: contentView)
        self.window = window
        window.makeKeyAndVisible()
    }
  }

}
