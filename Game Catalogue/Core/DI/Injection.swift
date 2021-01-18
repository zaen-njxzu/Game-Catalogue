//
//  Injection.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 12/01/21.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
  private func provideRepository() -> GameRepositoryProtocol {
    let realm = try? Realm()
    let local: LocalDataSource = LocalDataSource.sharedInstance(realm)
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance
    return GameRepository.sharedInstance(remote, local)
  }
  func provideFavourite() -> FavouriteUseCase {
    let repository = provideRepository()
    return FavouriteInteractor(repository: repository)
  }
  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }
  func provideDetail() -> DetailUseCase {
    let repository = provideRepository()
    return DetailInteractor(repository: repository)
  }
  func provideSearch() -> SearchUseCase {
    let repository = provideRepository()
    return SearchInteractor(repository: repository)
  }
}
