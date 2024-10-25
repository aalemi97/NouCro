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
    fileprivate let uuid: UUID = UUID()
    
    convenience init(name: String, color: String, icon: String) {
        self.init(context: PersistenceManager.shared.context)
        self.name = name
        self.color = color
        self.icon = icon
    }
}

extension Player: Storable {
    
    public var id: String {
        uuid.uuidString
    }

}
