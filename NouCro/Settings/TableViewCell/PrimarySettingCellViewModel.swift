//
//  PrimarySettingCellViewModel.swift
//  NouCro
//
//  Created by AliReza on 2024-10-30.
//

import Foundation
import Combine

class PrimarySettingCellViewModel: NSObject, Reusable {
    
    typealias Model = PrimarySettingModel
    private let model: Model
    private let cell: ReusableCell.Type
    private let value: PassthroughSubject<Int, Never> = PassthroughSubject()
    private var cancellables: Set<AnyCancellable> = []
    var valuePublisher: AnyPublisher<Int, Never> {
        value.eraseToAnyPublisher()
    }
    let currentPublisher: AnyPublisher<Int, Never>
    let minPublisher: AnyPublisher<Int, Never>
    let maxPublisher: AnyPublisher<Int, Never>
    var title: String {
        model.title
    }
    
    required init(model: Model, cell: ReusableCell.Type) {
        self.model = model
        self.currentPublisher = model.currentPublisher
        self.minPublisher = model.minPublisher
        self.maxPublisher = model.maxPublisher
        self.cell = cell
    }
    
    func getReuseID() -> String {
        return cell.reuseID
    }
    
    func send(_ newValue: Int) {
        value.send(newValue)
    }
    
    func update(property: PrimarySettingModel.Property, withValue value: Int) {
        model.update(property: property, withValue: value)
    }
    
    func get(property: PrimarySettingModel.Property) -> Double {
        Double(model.get(property: property))
    }
    
}
