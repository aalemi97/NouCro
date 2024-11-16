//
//  NCPlayer.swift
//  NouCro
//
//  Created by AliReza on 2024-10-25.
//
//

import Foundation
import CoreData
import Combine

@objc(NCPlayer)
public class NCPlayer: NSManagedObject {
    
    @NSManaged public var name: String
    @NSManaged public var color: NCColor
    @NSManaged public var icon: String
    @NSManaged public var uuid: UUID
    private var iconSubject: PassthroughSubject<String, Never> = .init()
    var iconPublihser: AnyPublisher<String, Never> {
        iconSubject.eraseToAnyPublisher()
    }
    
    convenience init() {
        self.init(context: PersistenceManager.shared.context)
        self.uuid = UUID()
        self.name = "New Player"
        self.color = .init(mode: .random)
        let icons = SelectIconViewModel.icons
        let index = Int.random(in: 0..<icons.count)
        self.icon = icons[index]
    }
    
    convenience init(name: String, color: NCColor, icon: String) {
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

extension NCPlayer: Storable, Identifiable {
    
}
