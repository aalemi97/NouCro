//
//  Player.swift
//  NouCro
//
//  Created by AliReza on 2024-10-25.
//
//

import Foundation
import CoreData
import Combine

@objc(Player)
public class Player: NSManagedObject {
    
    @NSManaged public var name: String
    @NSManaged public var color: Color
    @NSManaged public var icon: String
    @NSManaged public var uuid: UUID
    private var iconSubject: PassthroughSubject<String, Never> = .init()
    var iconPublihser: AnyPublisher<String, Never> {
        iconSubject.eraseToAnyPublisher()
    }
    
    convenience init(name: String, color: Color, icon: String) {
        self.init(context: PersistenceManager.shared.context)
        self.name = name
        self.color = color
        self.icon = icon
        self.uuid = UUID()
    }
    
    func setIconName(_ name: String) {
        self.icon = name
        iconSubject.send(name)
    }
}

extension Player: Storable, Identifiable {
    
}
