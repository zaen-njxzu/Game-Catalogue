//
//  StateWrappedView.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 21/01/21.
//

import SwiftUI

protocol ViewModelContainable: View {
    
    associatedtype ViewModel : ObservableObject
    init(model: ViewModel)
}

// This struct is a direct MVVM alternative to @StateObject in iOS 14 and Mac OS Big Sur.
struct StateWrapped<U: ViewModelContainable, T> : View
    where U.ViewModel == T
{
    @State var model: T
    var body : some View {
        U(model: model)
    }
}
