//
//  Color.swift
//  NouCro
//
//  Created by AliReza on 2024-11-11.
//

import Foundation
import CoreData

@objc(Color)
public class Color: NSManagedObject {
    
    enum ColorMode {
        case none
        case pink
        case purple
        case pinkPurple
        case random
    }
    
    @NSManaged public var red: Float
    @NSManaged public var green: Float
    @NSManaged public var blue: Float
    @NSManaged public var alpha: Float
    
    convenience init(red: Float, green: Float, blue: Float, alpha: Float) {
        self.init(context: PersistenceManager.shared.context)
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    convenience init(mode: ColorMode) {
        self.init(context: PersistenceManager.shared.context)
        switch mode {
        case .none:
            self.red = 0.0
            self.green = 0.0
            self.blue = 0.0
        case .pink:
            self.red = 0.8
            self.green = 0.267
            self.blue = 0.6
        case .purple:
            self.red = 0.4
            self.green = 0.239
            self.blue = 1.0
        case .pinkPurple:
            self.red = 0.667
            self.green = 0
            self.blue = 1.0
        case .random:
            self.red = Float.random(in: 0...1)
            self.green = Float.random(in: 0...1)
            self.blue = Float.random(in: 0...1)
        }
        self.alpha = 1.0
    }
    
}

extension Color: Identifiable {
    
}
