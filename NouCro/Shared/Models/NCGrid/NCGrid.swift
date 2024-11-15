//
//  NCGrid.swift
//  NouCro
//
//  Created by AliReza on 2024-10-25.
//
//

import Foundation
import CoreData

@objc(NCGrid)
public class NCGrid: NSManagedObject {
    
    @NSManaged public var dimension: Int16
    @NSManaged public var uuid: UUID
    
    convenience init(dimension: Int16) {
        self.init(context: PersistenceManager.shared.context)
        self.dimension = dimension
        self.uuid = UUID()
    }
}

extension NCGrid: Storable, Identifiable {
    
    var size: Int {
        return Int(dimension)
    }
    
    var grid: Int {
        return Int(dimension) * Int(dimension)
    }
    
}
