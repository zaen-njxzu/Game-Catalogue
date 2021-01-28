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
  public typealias Request = String
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
            .sorted(byKeyPath: "id", ascending: true)
        }()
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
  public func set(by id: String?) -> AnyPublisher<CatalogueModelEntity, Error> {
    fatalError()
  }

}
