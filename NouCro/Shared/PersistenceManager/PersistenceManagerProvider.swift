//
//  PersistenceManagerProvider.swift
//  NouCro
//
//  Created by AliReza on 2024-10-23.
//

import Combine
import CoreData

protocol PersistenceManagerProvider {
    var context: NSManagedObjectContext { get }
    func get<DataType: Storable>() -> AnyPublisher<[DataType], NCError>
    @discardableResult func save() -> AnyPublisher<Bool, NCError>
    @discardableResult func delete<DataType: Storable>(data: DataType) -> AnyPublisher<Bool, NCError>
    @discardableResult func deleteDatabase(for entity: String) -> AnyPublisher<Bool, NCError>
}
