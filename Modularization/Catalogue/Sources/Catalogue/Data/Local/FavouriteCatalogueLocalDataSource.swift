//
//  FavouriteCatalogueLocalDataSource.swift
//  
//
//  Created by Zaenal Arsy on 27/01/21.
//

import Foundation
import Combine
import RealmSwift
import CoreSDK

public struct FavouriteCatalogueLocalDataSource: LocalDataSource {
  public typealias Request = Int
  public typealias Response = CatalogueModelEntity
  private let _realm: Realm?
  public init(realm: Realm?) {
      _realm = realm
  }
  public func get() -> AnyPublisher<[CatalogueModelEntity], Error> {
    return Future<[CatalogueModelEntity], Error> { completion in
      if let realm = self._realm {
        let categories: Results<CatalogueModelEntity> = {
          realm.objects(CatalogueModelEntity.self)
            .filter("favourite = \(true)")
            .sorted(byKeyPath: "id", ascending: true)
        }()
        print(categories)
        completion(.success(categories.toArray(ofType: CatalogueModelEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  public func add(from entities: [CatalogueModelEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self._realm {
        do {
            try realm.write {
                for entity in entities {
                    realm.add(entity, update: .all)
                }
                completion(.success(true))
            }
        } catch {
            completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  public func set(by id: Int?) -> AnyPublisher<CatalogueModelEntity, Error> {
    return Future<CatalogueModelEntity, Error> { completion in
      guard let id = id else { return completion(.failure(DatabaseError.invalidParameter)) }
      if let realm = self._realm, let entity = {
        realm.objects(CatalogueModelEntity.self).filter("id = \(id)")
      }().first {
        do {
          try realm.write {
            entity.setValue(!entity.favourite, forKey: "favourite")
          }
          completion(.success(entity))
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }

}
