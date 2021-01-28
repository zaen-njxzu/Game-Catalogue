//
//  FavouriteCataloguePresenter.swift
//  
//
//  Created by Zaenal Arsy on 27/01/21.
//

import Foundation
import Combine
import CoreSDK

public class FavouriteCataloguePresenter<FavouriteUseCase: UseCase, ModifyFavouriteUseCase: UseCase>: ObservableObject
where
  FavouriteUseCase.Request == Int, FavouriteUseCase.Response == [CatalogueDomainModel],
  ModifyFavouriteUseCase.Request == CatalogueDomainModel, ModifyFavouriteUseCase.Response == CatalogueDomainModel
{
  private var cancellables: Set<AnyCancellable> = []
  private let _favouriteUseCase: FavouriteUseCase?
  private let _modifyUseCase: ModifyFavouriteUseCase?
  @Published public var list: [CatalogueDomainModel] = []
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false
  public init(favouriteUseCase: FavouriteUseCase?, modifyUseCase: ModifyFavouriteUseCase?) {
    _favouriteUseCase = favouriteUseCase
    _modifyUseCase = modifyUseCase
  }
  public func getFavouriteCatalogue() {
    print("getFavouriteCatalogue called")
    isLoading = true
    if let _favouriteUseCase = _favouriteUseCase {
      _favouriteUseCase.execute(request: nil)
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
          switch completion {
          case .failure (let error):
            print(error.localizedDescription)
            self.errorMessage = error.localizedDescription
            self.isError = true
            self.isLoading = false
          case .finished:
            self.isLoading = false
          }
        }, receiveValue: { list in
          print(list)
          self.list = list
        })
        .store(in: &cancellables)
    } else {
      print("Favourite use case has no value.")
      self.errorMessage = "Favourite use case has no value."
      self.isError = true
      self.isLoading = false
    }
  }
  public func favouriteCatalogue(catalogue: CatalogueDomainModel, completion: @escaping (Bool, ModifyFavouriteUseCase.Response) -> Void) {
    if let _modifyUseCase = _modifyUseCase {
      _modifyUseCase.execute(request: catalogue)
        .subscribe(on: RunLoop.main)
        .sink { _completion in
          switch _completion {
          case .failure(_):
            completion(false, catalogue)
          case .finished: break
          }
        } receiveValue: { _catalogue in
          completion(true, _catalogue)
        }
        .store(in: &cancellables)
    } else {
      completion(false, catalogue)
    }
  }
}
