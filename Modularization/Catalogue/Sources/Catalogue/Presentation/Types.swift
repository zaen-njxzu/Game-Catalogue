//
//  Types.swift
//  
//
//  Created by Zaenal Arsy on 27/01/21.
//

import Foundation
import CoreSDK

public typealias CataloguePresenter = GetListPresenter<
  String,
  CatalogueDomainModel,
  Interactor<
    String,
    [CatalogueDomainModel],
    GetCatalogueRepository<
      GetCatalogueLocalDataSource,
      GetCatalogueRemoteDataSource,
      CatalogueTransformer
    >
  >
>

public typealias SearchCataloguePresenter = GetListPresenter<
  String,
  CatalogueDomainModel,
  Interactor<
    String,
    [CatalogueDomainModel],
    SearchCatalogueRepository<
      SearchCatalogueRemoteSource,
      CatalogueTransformer
    >
  >
>

public typealias FavouriteCatalogueUseCase = Interactor<
  Int,
  [CatalogueDomainModel],
  FavouriteCatalogueRepository<
    FavouriteCatalogueLocalDataSource,
    CatalogueTransformer
  >
>

public typealias DetailCatalogueUseCase = Interactor<
  Int,
  DetailCatalogueDomainModel,
  GetDetailCatalogueRepository<
    GetDetailCatalogueRemoteDataSource,
    SingleDetailCatalogueTransformer
  >
>

public typealias ModifyFavouriteCatalogueUseCase = Interactor<
  CatalogueDomainModel,
  CatalogueDomainModel,
  ModifyFavouriteCatalogueRepository<
    FavouriteCatalogueLocalDataSource,
    SingleCatalogueTransformer
  >
>

public typealias FavouriteCataloguePresenterAlias = FavouriteCataloguePresenter<
  FavouriteCatalogueUseCase,
  ModifyFavouriteCatalogueUseCase
>

public typealias DetailCataloguePresenterAlias = DetailCataloguePresenter<
  DetailCatalogueUseCase,
  ModifyFavouriteCatalogueUseCase
>
