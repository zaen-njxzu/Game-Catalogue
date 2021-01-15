//
//  ProfileView.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 11/01/21.
//

import SwiftUI

struct ProfileView: View {
  @Environment(\.presentationMode) var presentationMode

  var body: some View {
    ZStack {
      Color(UIColor.Ext.Blue)
      VStack {
        VStack {
          Image("profile")
            .resizable()
            .clipShape(Circle())
            .frame(width: 100, height: 100, alignment: .center)
            .shadow(radius: 4)
            .padding()
          Text("Zaenal Arsy")
            .bold()
          Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 48, height: 200)
        .cornerRadius(20)
        .background(Color.white
                        .cornerRadius(20)
                        .shadow(color: Color(UIColor.Ext.DarkBlue), radius: 6, x: 4.0, y: 4.0)
        ).padding()
        Spacer()
      }
    }
    .navigationBarTitle(
      Text("My Profile"),
        displayMode: .inline
    )
    .navigationBarItems(leading: Button(
                          action: {
                            presentationMode.wrappedValue.dismiss()
                          }, label: {
                            Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .imageScale(.large)
                          })
    )
    .background(NavigationConfigurator { navController in
      navController.navigationBar.barTintColor = UIColor.Ext.DarkBlue
      navController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    })
    .navigationBarBackButtonHidden(true)
    .navigationViewStyle(StackNavigationViewStyle())

  }
}
