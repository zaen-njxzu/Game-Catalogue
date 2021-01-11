//
//  GameModel.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 11/01/21.
//

import Foundation

struct GameModel: Equatable, Identifiable {
    let id: Int
    let name: String
    let releasedAt: String
    let imageUrl: String
    let rating: String
}
