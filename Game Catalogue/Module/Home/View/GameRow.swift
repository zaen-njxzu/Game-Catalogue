//
//  GameRow.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 10/01/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Catalogue

struct GameRow: View {

  var game: CatalogueDomainModel
  var body: some View {
    HStack {
      imageGame
      Spacer(minLength: 4)
      infoGame
    }
    .frame(width: 310, height: 110)
    .cornerRadius(20)
    .background(Color.white
                    .cornerRadius(20)
                    .shadow(color: Color(UIColor.Ext.DarkBlue), radius: 6, x: 6.0, y: 6.0)
    )
  }

}

extension GameRow {
    var imageGame: some View {
      WebImage(url: URL(string: game.imageUrl))
        .resizable()
        .indicator(.activity)
        .transition(.fade(duration: 0.5))
        .scaledToFill()
        .frame(width: 150)
        .cornerRadius(40, corners: [.topRight, .bottomRight])
    }
    var infoGame: some View {
      VStack(alignment: .trailing, spacing: 8) {
        Text(game.name)
          .foregroundColor(.black)
          .bold()
        Text(game.releasedAt)
          .foregroundColor(.black)
        HStack(alignment: .center, spacing: 4) {
          Text(game.rating)
            .foregroundColor(.black)
          Image(systemName: "star.fill")
            .resizable()
            .foregroundColor(Color(UIColor.Ext.DarkBlue))
            .frame(width: 16, height: 16, alignment: .center)
        }
        Spacer()
      }.padding()
    }
}
