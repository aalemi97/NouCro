//
//  MainSettingModel.swift
//  NouCro
//
//  Created by AliReza on 2024-10-21.
//

import Foundation

class MainSettingModel: NSObject {
    let title: String
    let index: Int
    let minValue: Int
    let maxValue: Int
    init(title: String, index: Int, minValue: Int, maxValue: Int) {
        self.title = title
        self.index = index
        self.minValue = minValue
        self.maxValue = maxValue
    }
}
