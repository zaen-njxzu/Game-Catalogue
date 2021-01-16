//
//  RealmResults+Ext.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 16/01/21.
//

import Foundation
import RealmSwift

extension Results {

  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

}
