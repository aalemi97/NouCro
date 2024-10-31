//
//  PrimarySettingModel.swift
//  NouCro
//
//  Created by AliReza on 2024-10-21.
//

import Foundation

class PrimarySettingModel: NSObject {
    
    let title: String
    let value: Int
    let minValue: Int
    let maxValue: Int
    
    init(title: String, value: Int, minValue: Int, maxValue: Int) {
        self.title = title
        self.value = value
        self.minValue = minValue
        self.maxValue = maxValue
    }
}
