//
//  UIColor+Ext.swift
//  NouCro
//
//  Created by AliReza on 2024-10-30.
//

import UIKit.UIColor

extension UIColor {
    public convenience init(hex: String) {
        let r, g, b: CGFloat
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...]).lowercased()
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
                    b = CGFloat((hexNumber & 0x0000FF) >> 0) / 255
                    self.init(red: r, green: g, blue: b, alpha: 1)
                    return
                }
            }
        }
        self.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    }
}
