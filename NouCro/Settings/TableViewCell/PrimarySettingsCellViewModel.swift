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
    var cell: ReusableCell.Type
    
    required init(model: Model, cell: ReusableCell.Type) {
        self.model = model
        self.cell = cell
    }
    
    func getModel() -> PrimarySettingModel {
        return model
    }
    
    func getReuseID() -> String {
        return cell.reuseID
    }
}
