//
//  PrimarySettingModel.swift
//  NouCro
//
//  Created by AliReza on 2024-10-21.
//

import Foundation
import Combine

class PrimarySettingModel: NSObject {
    
    // MARK: - enum: class properties
    enum Property {
        case current, min, max
    }
    
    //MARK: - properties
    private var current: CurrentValueSubject<Int, Never>
    private var min: CurrentValueSubject<Int, Never>
    private var max: CurrentValueSubject<Int, Never>
    let title: String
    
    var currentPublisher: AnyPublisher<Int, Never> {
        return current.eraseToAnyPublisher()
    }
    
    var minPublisher: AnyPublisher<Int, Never> {
        return min.eraseToAnyPublisher()
    }
    
    var maxPublisher: AnyPublisher<Int, Never> {
        return max.eraseToAnyPublisher()
    }
    
    //MARK: - methods
    init(current: Int, min: Int, max: Int, title: String) {
        self.current = CurrentValueSubject(current)
        self.min = CurrentValueSubject(min)
        self.max = CurrentValueSubject(max)
        self.title = title
    }
    
    func update(property: Property, withValue value: Int) {
        switch property {
        case .current:
            current.send(value)
        case .min:
            min.send(value)
        case .max:
            max.send(value)
        }
    }
    
    func get(property: Property) -> Int {
        switch property {
        case .current:
            return current.value
        case .min:
            return min.value
        case .max:
            return max.value
        }
    }
    
}
