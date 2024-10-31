//
//  Reusable.swift
//  NouCro
//
//  Created by AliReza on 2024-10-30.
//

import Foundation

protocol Reusable {
    associatedtype Model: Hashable
    var model: Model { get }
    var cellClass: AnyClass { get }
    var reuseID: String { get }
}
