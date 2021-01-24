//
//  ListSeparatorStyleNoneModifier.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 21/01/21.
//

import SwiftUI

public struct ListSeparatorStyleNoneModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content.onAppear {
          UITableView.appearance().separatorStyle = .none
          UITableView.appearance().backgroundColor = UIColor.Ext.Blue
          UITableViewCell.appearance().backgroundColor = UIColor.Ext.Blue
          UITableViewCell.appearance().selectionStyle = .none
        }.onDisappear {
          UITableView.appearance().separatorStyle = .singleLine
          UITableView.appearance().backgroundColor = .none
          UITableViewCell.appearance().backgroundColor = .none
        }
    }
}
