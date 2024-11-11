//
//  Player.swift
//  NouCro
//
//  Created by AliReza on 2024-10-25.
//
//

import Foundation
import CoreData

@objc(Player)
public class Player: NSManagedObject {
    
    @NSManaged public var name: String
    @NSManaged public var color: String
    @NSManaged public var icon: String
    @NSManaged public var uuid: UUID
    
    convenience init(name: String, color: String, icon: String) {
        self.init(context: PersistenceManager.shared.context)
        self.name = name
        self.color = color
        self.icon = icon
        self.uuid = UUID()
    }
}

extension Player: Storable, Identifiable {
    
}
