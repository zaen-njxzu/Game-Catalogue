//
//  GameEntity.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 16/01/21.
//

import Foundation
import RealmSwift

class GameEntity: Object {
  @objc dynamic var id: Int = 0
  @objc dynamic var name: String = ""
  @objc dynamic var released: String = ""
  @objc dynamic var backgroundImage: String = ""
  @objc dynamic var rating: String = ""
  @objc dynamic var favourite = false
  override class func primaryKey() -> String? {
    return "id"
  }
}
