//
//  DetailGameModel.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 11/01/21.
//

import Foundation

struct DetailGameModel: Equatable, Identifiable {
  let id: Int
  let name: String
  let description: String
  let imageUrl: String
  let releasedAt: String
  let rating: String
}
