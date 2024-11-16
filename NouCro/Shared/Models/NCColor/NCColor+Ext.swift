//
//  NCColor+Ext.swift
//  NouCro
//
//  Created by AliReza on 2024-11-14.
//

import UIKit.UIColor

extension NCColor {
    var uiColor: UIColor {
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
}