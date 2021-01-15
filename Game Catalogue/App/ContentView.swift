//
//  ContentView.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 10/01/21.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var homePresenter: HomePresenter

  var body: some View {
    NavigationView {
      HomeView(presenter: homePresenter)
    }
  }
}
