//
//  ActivityIndicator.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 12/01/21.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

  func makeUIView(
    context: UIViewRepresentableContext<ActivityIndicator>
  ) -> UIActivityIndicatorView {
    return UIActivityIndicatorView(style: .large)
  }
  
  func updateUIView(
    _ uiView: UIActivityIndicatorView,
    context: UIViewRepresentableContext<ActivityIndicator>
  ) {
    uiView.color = .white
    uiView.startAnimating()
  }

}
