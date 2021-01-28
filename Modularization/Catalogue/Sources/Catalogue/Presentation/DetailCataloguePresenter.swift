//
//  DetailCataloguePresenter.swift
//  
//
//  Created by Zaenal Arsy on 28/01/21.
//

import Foundation
import Combine
import CoreSDK

public class DetailCataloguePresenter<DetailUseCase: UseCase, ModifyFavouriteUseCase: UseCase>: ObservableObject
where
  DetailUseCase.Request == Int, DetailUseCase.Response == DetailCatalogueDomainModel,
  ModifyFavouriteUseCase.Request == CatalogueDomainModel, ModifyFavouriteUseCase.Response == CatalogueDomainModel
{
  private var cancellables: Set<AnyCancellable> = []
  private let _detailUseCase: DetailUseCase?
  private let _modifyUseCase: ModifyFavouriteUseCase?
  @Published public var catalogue: CatalogueDomainModel
  @Published public var detail: DetailCatalogueDomainModel?
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false
  public init(_catalogue: CatalogueDomainModel, detailUseCase: DetailUseCase?, modifyUseCase: ModifyFavouriteUseCase?) {
    catalogue = _catalogue
    _detailUseCase = detailUseCase
    _modifyUseCase = modifyUseCase
  }
  public func getDetailCatalogue() {
    isLoading = true
    if let _detailUseCase = _detailUseCase {
      _detailUseCase.execute(request: catalogue.id)
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
        }, receiveValue: { detail in
          self.detail = detail
        })
        .store(in: &cancellables)
    } else {
      self.errorMessage = "Detail use case has no value."
      self.isError = true
      self.isLoading = false
    }
  }
  public func favouriteCatalogue(completion: @escaping (Bool, ModifyFavouriteUseCase.Response) -> Void) {
    if let _modifyUseCase = _modifyUseCase {
      _modifyUseCase.execute(request: catalogue)
        .subscribe(on: RunLoop.main)
        .sink { _completion in
          switch _completion {
          case .failure:
            completion(false, self.catalogue)
          case .finished: break
          }
        } receiveValue: { _catalogue in
          self.catalogue = _catalogue
          completion(true, _catalogue)
        }
        .store(in: &cancellables)
    } else {
      completion(false, catalogue)
    }
  }
}
