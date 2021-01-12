//
//  DetailPresenter.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 12/01/21.
//

import SwiftUI

class DetailPresenter: ObservableObject {

    private let detailUseCase: DetailUseCase
    private let id: Int

    @Published var detailGame: DetailGameModel?
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false

    init(id: Int, detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
        self.id = id
    }
    
    func getDetailGame() {
        loadingState = true
        detailUseCase.getDetailGame(with: id) { (result) in
            switch result {
            case .success(let detail):
                print(detail)
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.detailGame = detail
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

}
