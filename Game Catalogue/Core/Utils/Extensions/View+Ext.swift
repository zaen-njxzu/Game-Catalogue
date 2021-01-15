//
//  View+Ext.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 11/01/21.
//

import SwiftUI

extension View {
  func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
    clipShape( RoundedCorner(radius: radius, corners: corners) )
  }
}
