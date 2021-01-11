//
//  UIColor+Ext.swift
//  Game Catalogue
//
//  Created by Zaenal Arsy on 11/01/21.
//

import SwiftUI

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    struct Ext {
        static let Blue = UIColor(netHex: 0x1A508B)
        static let DarkBlue = UIColor(netHex: 0x0D335D)
        static let Cream = UIColor(netHex: 0xFFF3E6)
    }

}
