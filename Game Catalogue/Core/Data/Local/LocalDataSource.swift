//
//  LocalDataSource.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 16/01/21.
//

import Foundation
import RealmSwift

protocol LocalDataSourceProtocol: class {
  func getGames(result: @escaping (Result<[GameEntity], DatabaseError>) -> Void)
  func addGame(
    from games: GameEntity,
    result: @escaping (Result<Bool, DatabaseError>) -> Void
  )
  func deleteGame(
    with gameId: Int,
    result: @escaping (Result<Bool, DatabaseError>) -> Void
  )
}

final class LocalDataSource: NSObject {
  private let realm: Realm?

  private init(realm: Realm?) {
    self.realm = realm
  }

  static let sharedInstance: (Realm?) -> LocalDataSource = { realmDatabase in
    return LocalDataSource(realm: realmDatabase)
  }
}

extension LocalDataSource: LocalDataSourceProtocol {
  func deleteGame(with gameId: Int, result: @escaping (Result<Bool, DatabaseError>) -> Void) {
    if let realm = realm {
      do {
        try realm.write {
          if let game = realm.object(ofType: GameEntity.self, forPrimaryKey: gameId) {
            realm.delete(game)
            result(.success(true))
          } else {
            result(.failure(.requestFailed))
          }
        }
      } catch {
        result(.failure(.requestFailed))
      }
    } else {
      result(.failure(.invalidInstance))
    }
  }
  func getGames(result: @escaping (Result<[GameEntity], DatabaseError>) -> Void) {
    if let realm = realm {
      let games: Results<GameEntity> = {
        realm.objects(GameEntity.self)
          .sorted(byKeyPath: "id", ascending: true)
      }()
      result(.success(games.toArray(ofType: GameEntity.self)))
    } else {
      result(.failure(.invalidInstance))
    }
  }
  func addGame(from game: GameEntity, result: @escaping (Result<Bool, DatabaseError>) -> Void) {
    if let realm = realm {
      do {
        try realm.write {
          realm.add(game, update: .all)
          result(.success(true))
        }
      } catch {
        result(.failure(.requestFailed))
      }
    } else {
      result(.failure(.invalidInstance))
    }
  }
}
