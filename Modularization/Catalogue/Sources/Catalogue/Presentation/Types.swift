//
//  Types.swift
//  
//
//  Created by Zaenal Arsy on 27/01/21.
//

import Foundation
import CoreSDK

public typealias CataloguePresenter = GetListPresenter<String, CatalogueDomainModel, Interactor<String, [CatalogueDomainModel], GetCatalogueRepository<GetCatalogueLocalDataSource, GetCatalogueRemoteDataSource, CatalogueTransformer>>>

public typealias SearchCataloguePresenter = GetListPresenter<String, CatalogueDomainModel, Interactor<String, [CatalogueDomainModel], SearchCatalogueRepository<SearchCatalogueRemoteSource, CatalogueTransformer>>>
