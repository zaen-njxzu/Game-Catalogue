//
//  Injection.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 12/01/21.
//

import Foundation
import RealmSwift
import CoreSDK
import Catalogue
import UIKit

final class Injection: NSObject {
  func provideCatalogue<U: UseCase>() -> U where U.Request == Any, U.Response == [CatalogueDomainModel] {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let local = GetCatalogueLocalDataSource(realm: appDelegate.realm)
    let remote = GetCatalogueRemoteDataSource(endpoint: Endpoints.Gets.gameList.url)
    let mapper = CatalogueTransformer()
    let repository = GetCatalogueRepository(
      localDataSource: local,
      remoteDataSource: remote,
      mapper: mapper)
    return Interactor(repository: repository) as! U
  }
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
