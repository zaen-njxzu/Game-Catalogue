//
//  Injection.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 12/01/21.
//

import Foundation

final class Injection: NSObject {
  
  private func provideRepository() -> GameRepositoryProtocol {

    let remote: RemoteDataSource = RemoteDataSource.sharedInstance

    return GameRepository.sharedInstance(remote)
  }

  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }

  func provideDetail() -> DetailUseCase {
    let repository = provideRepository()
    return DetailInteractor(repository: repository)
  }

}
