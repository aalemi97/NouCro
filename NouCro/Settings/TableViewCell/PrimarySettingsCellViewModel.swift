//
//  PrimarySettingsCellViewModel.swift
//  NouCro
//
//  Created by AliReza on 2024-10-30.
//

import Foundation

class PrimarySettingsCellViewModel: NSObject, Reusable {
    
    typealias Model = PrimarySettingModel
    var model: Model
    var cellClass: AnyClass
    var reuseID: String
    
    init(model: Model, cellClass: AnyClass, reuseID: String) {
        self.model = model
        self.cellClass = cellClass
        self.reuseID = reuseID
    }
}
