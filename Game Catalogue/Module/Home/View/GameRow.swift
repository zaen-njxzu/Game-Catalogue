//
//  GameRow.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 10/01/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameRow: View {

    var game: GameModel
    
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
                .bold()
                .font(.system(size: 14))
            Text(game.releasedAt)
                .font(.system(size: 12))
            HStack(alignment: .center, spacing: 4) {
                Text(game.rating)
                    .font(.system(size: 12))
                Image(systemName: "star.fill")
                    .resizable()
                    .foregroundColor(Color(UIColor.Ext.DarkBlue))
                    .frame(width: 16, height: 16, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            Spacer()
        }.padding()
    }
}
