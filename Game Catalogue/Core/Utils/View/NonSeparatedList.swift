//
//  NonSeparatedList.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 21/01/21.
//

import SwiftUI

struct NonSeparatedList<Content: View>: View {
    var content: () -> Content
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    var body: some View {
        if #available(iOS 14.0, *) {
            ScrollView {
                LazyVStack(spacing: 0) {
                    content()
                }
            }
        } else {
            List {
                content()
            }.listSeparatorStyleNone() // set spacing
        }
    }
}
