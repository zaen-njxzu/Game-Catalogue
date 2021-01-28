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
  func provideFavouritePresenter() -> FavouriteCataloguePresenterAlias {
    let favouriteUsecase: FavouriteCatalogueUseCase? = Injection.init().provideFavouriteCatalogue()
    let modifyUsecase: ModifyFavouriteCatalogueUseCase? = Injection.init().provideModifyFavouriteCatalogue()
    return FavouriteCataloguePresenter(favouriteUseCase: favouriteUsecase, modifyUseCase: modifyUsecase)
  }
  func provideDetailPresenter(catalogue: CatalogueDomainModel) -> DetailCataloguePresenterAlias {
    let detailUsecase: DetailCatalogueUseCase? = Injection.init().provideDetailCatalogue()
    let modifyUsecase: ModifyFavouriteCatalogueUseCase? = Injection.init().provideModifyFavouriteCatalogue()
    return DetailCataloguePresenterAlias(_catalogue: catalogue, detailUseCase: detailUsecase, modifyUseCase: modifyUsecase)
  }
  func provideDetailCatalogue<U: UseCase>() -> U? where U.Request == Int, U.Response == DetailCatalogueDomainModel {
    let remote = GetDetailCatalogueRemoteDataSource(endpoint: Endpoints.Gets.detailGame.url)
    let mapper = SingleDetailCatalogueTransformer()
    let repository = GetDetailCatalogueRepository(
      remoteDataSource: remote,
      mapper: mapper)
    return Interactor(repository: repository) as? U
  }
  func provideFavouriteCatalogue<U: UseCase>() -> U? where U.Request == Int, U.Response == [CatalogueDomainModel] {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let local = FavouriteCatalogueLocalDataSource(realm: appDelegate?.realm)
    let mapper = CatalogueTransformer()
    let repository = FavouriteCatalogueRepository(
      localDataSource: local,
      mapper: mapper)
    return Interactor(repository: repository) as? U
  }
  func provideModifyFavouriteCatalogue<U: UseCase>() -> U? where U.Request == CatalogueDomainModel, U.Response == CatalogueDomainModel {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let local = FavouriteCatalogueLocalDataSource(realm: appDelegate?.realm)
    let mapper = SingleCatalogueTransformer()
    let repository = ModifyFavouriteCatalogueRepository(
      localDataSource: local,
      mapper: mapper)
    return Interactor(repository: repository) as? U
  }
  func provideSearchCatalogue<U: UseCase>() -> U? where U.Request == String, U.Response == [CatalogueDomainModel] {
    let remote = SearchCatalogueRemoteSource(endpoint: Endpoints.Gets.searchGame.url)
    let mapper = CatalogueTransformer()
    let repository = SearchCatalogueRepository(
      remoteDataSource: remote,
      mapper: mapper)
    return Interactor(repository: repository) as? U
  }
  func provideCatalogue<U: UseCase>() -> U? where U.Request == String, U.Response == [CatalogueDomainModel] {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let local = GetCatalogueLocalDataSource(realm: appDelegate?.realm)
    let remote = GetCatalogueRemoteDataSource(endpoint: Endpoints.Gets.gameList.url)
    let mapper = CatalogueTransformer()
    let repository = GetCatalogueRepository(
      localDataSource: local,
      remoteDataSource: remote,
      mapper: mapper)
    return Interactor(repository: repository) as? U
  }
}
