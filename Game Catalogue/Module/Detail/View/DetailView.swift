//
//  DetailView.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 12/01/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var presenter: DetailPresenter

    var body: some View {
        ZStack {
            Color(UIColor.Ext.Blue)
            VStack {
                if presenter.loadingState {
                    loadingIndicator
                } else {
                    if let detail = presenter.detailGame {
                        mainContent(detail: detail)
                            .padding(.top, 20)
                        Spacer()
                    } else {
                        Text("Empty Data")
                            .bold()
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .onAppear() {
            if presenter.detailGame == nil {
                presenter.getDetailGame()
            }
        }
        .navigationBarTitle(
          Text("My Profile"),
            displayMode: .inline
        )
        .navigationBarItems(leading:
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .imageScale(.large)
                })
        )
        .background(NavigationConfigurator { nc in
            nc.navigationBar.barTintColor = UIColor.Ext.DarkBlue
            nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        })
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension DetailView {
    var loadingIndicator: some View {
        VStack {
          Text("Loading...")
              .bold()
              .foregroundColor(.white)
          ActivityIndicator()
        }
    }
    
    func mainContent(detail: DetailGameModel) -> some View {
        VStack {
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    gameImage(url: detail.imageUrl)
                    rating(rating: detail.rating)
                }.padding(.vertical, 20)
                
                infoDetail(title: "Name: ", value: detail.name)
                infoDetail(title: "Released At: ", value: detail.releasedAt)
                
                HStack {
                    Text("Description")
                        .padding(.leading, 20)
                        .font(.system(size: 12))
                    Spacer()
                }.padding(.vertical, 2)
                
                HStack {
                    Text(detail.description)
                        .bold()
                        .padding(.leading, 20)
                        .font(.system(size: 12))
                    Spacer()
                }.padding(.vertical, 2)
                
            }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 48, height: 400)
        .cornerRadius(20)
        .background(Color.white
                        .cornerRadius(20)
                        .shadow(color: Color(UIColor.Ext.DarkBlue), radius: 6, x: 4.0, y: 4.0)
        )
    }
    
    func infoDetail(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .padding(.leading, 20)
                .font(.system(size: 12))
            Text(value)
                .font(.system(size: 12))
                .bold()
            Spacer()
        }
    }
    
    func rating(rating: String) -> some View {
        VStack {
            ZStack {
                Color(UIColor.Ext.Cream)
                HStack(alignment: .center, spacing: 6) {
                    Text(rating)
                        .font(.system(size: 12))
                        .padding(.horizontal, 2)
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundColor(Color(UIColor.Ext.DarkBlue))
                        .frame(width: 16, height: 16, alignment: .center)
                        .padding(.horizontal, 2)
                }
            }
        }
        .cornerRadius(10, corners: [.topLeft, .bottomRight])
        .frame(width: 90, height: 30)
    }
    
    func gameImage(url: String) -> some View {
        WebImage(url: URL(string: url))
            .resizable()
            .indicator(.activity)
            .cornerRadius(10, corners: [.allCorners])
            .transition(.fade(duration: 0.5))
            .frame(width: 220.0, height: 110.0, alignment: .center)
    }
    
}
