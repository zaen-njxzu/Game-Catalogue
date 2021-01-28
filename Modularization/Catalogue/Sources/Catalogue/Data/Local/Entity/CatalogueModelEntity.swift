//
//  CatalogueModelEntity.swift.swift
//  
//
//  Created by Zaenal Arsy on 25/01/21.
//

import Foundation
import RealmSwift

public class CatalogueModelEntity: Object {
  @objc dynamic var id: Int = 0
  @objc dynamic var name: String = ""
  @objc dynamic var released: String = ""
  @objc dynamic var backgroundImage: String = ""
  @objc dynamic var rating: String = ""
  @objc dynamic var favourite = false
  public override static func primaryKey() -> String? {
    return "id"
  }
}
