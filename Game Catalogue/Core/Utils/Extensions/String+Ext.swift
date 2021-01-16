//
//  String+Ext.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 16/01/21.
//

import Foundation

extension String {
  /// Date String format from current format into converted format
  /// - Parameters:
  ///   - currentFormat: "yyyy-MM-dd" (example format)
  ///   - convertedFormat: "dd MMMM yyyy" (example format)
  ///   - date: "2010-12-20" (example date string from current format)
  /// - Returns: "20 December 2010" (example return date string from converted format)
  func toDate(from currentFormat: String, to convertedFormat: String, with currentDate: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = currentFormat
    guard let _currentDate = inputFormatter.date(from: currentDate) else {
      return currentDate
    }
    inputFormatter.dateFormat = convertedFormat
    return inputFormatter.string(from: _currentDate)
  }
}
