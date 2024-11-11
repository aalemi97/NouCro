//
//  GridSize.swift
//  NouCro
//
//  Created by AliReza on 2024-10-25.
//
//

import Foundation
import CoreData

@objc(GridSize)
public class GridSize: NSManagedObject {
    
    @NSManaged public var size: Int16
    @NSManaged public var uuid: UUID
    
    convenience init(size: Int16) {
        self.init(context: PersistenceManager.shared.context)
        self.size = size
        self.uuid = UUID()
    }
}

extension GridSize: Storable, Identifiable {
    
}
