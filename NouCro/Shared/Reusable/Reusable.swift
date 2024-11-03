//
//  Reusable.swift
//  NouCro
//
//  Created by AliReza on 2024-10-30.
//

import Foundation

protocol Reusable {
    associatedtype Model: Hashable
    init(model: Model, cell: ReusableCell.Type)
    func getModel() -> Model
    func getReuseID() -> String
}
