//
//  Storable.swift
//  NouCro
//
//  Created by AliReza on 2024-10-23.
//

import Foundation
import CoreData

protocol Storable: Hashable, NSManagedObject {
    static var descriptor: String { get }
    var id: String { get }
}

extension Storable {
    static var descriptor: String {
        return String(describing: Self.self)
    }
}
