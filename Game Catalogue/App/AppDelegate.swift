//
//  AppDelegate.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 10/01/21.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var realm: Realm!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    realm = try! Realm(configuration: configuration)

    UINavigationBar.appearance().backgroundColor = UIColor.Ext.DarkBlue
    UINavigationBar.appearance().largeTitleTextAttributes = [
      .foregroundColor: UIColor.white
    ]
    UINavigationBar.appearance().barTintColor = UIColor.Ext.DarkBlue
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    // Override point for customization after application launch.
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
      return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
  }

}
