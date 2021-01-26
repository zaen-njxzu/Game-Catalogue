//
//  GetCatalogueLocalDataSource.swift
//  
//
//  Created by Zaenal Arsy on 25/01/21.
//

import Foundation
import Combine
import RealmSwift
import CoreSDK

public struct GetCatalogueLocalDataSource: LocalDataSource {
 
  public typealias Request = Any
  public typealias Response = CatalogueModelEntity
  private let _realm: Realm
  public init(realm: Realm) {
      _realm = realm
  }
  public func get() -> AnyPublisher<[CatalogueModelEntity], Error> {
    return Future<[CatalogueModelEntity], Error> { completion in
        let categories: Results<CatalogueModelEntity> = {
          _realm.objects(CatalogueModelEntity.self)
            .sorted(byKeyPath: "id", ascending: true)
        }()
        completion(.success(categories.toArray(ofType: CatalogueModelEntity.self)))
    }.eraseToAnyPublisher()
  }
  public func add(from entities: [CatalogueModelEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
        do {
            try _realm.write {
                for entity in entities {
                    _realm.add(entity, update: .all)
                }
                completion(.success(true))
            }
        } catch {
            completion(.failure(DatabaseError.requestFailed))
        }
    }.eraseToAnyPublisher()
  }

}
