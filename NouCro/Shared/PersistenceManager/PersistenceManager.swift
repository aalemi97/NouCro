//
//  PersistenceManager.swift
//  NouCro
//
//  Created by AliReza on 2024-10-23.
//

import UIKit
import CoreData
import Combine

class PersistenceManager: PersistenceManagerProvider {
    
    static let shared: PersistenceManagerProvider = PersistenceManager()
    let context: NSManagedObjectContext
    private var cancellables: Set<AnyCancellable>
    
    private init() {
        let container = NSPersistentContainer(name: "NouCro")
        container.loadPersistentStores { (storeDescription, error) in
            if let error {
                fatalError(error.localizedDescription)
            }
        }
        self.context = container.viewContext
        self.cancellables = []
    }
    
    func get<DataType>() -> AnyPublisher<[DataType], NCError> where DataType : Storable {
        return Future<[DataType], NCError> { [weak self] promise in
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: DataType.descriptor)
            do {
                if let result = try self?.context.fetch(request) as? [DataType], result.count > 0 {
                    promise(.success(result))
                } else {
                    promise(.failure(.dataBaseError(message: "Could not find specified type, \(DataType.descriptor) in database.")))
                }
            } catch {
                promise(.failure(.dataBaseError(message: error.localizedDescription)))
            }
        }.eraseToAnyPublisher()
    }
    
    func save() -> AnyPublisher<Bool, NCError> {
        return Future<Bool, NCError> { [weak self] promise in
            guard self?.context.hasChanges ?? false else {
                promise(.success(true))
                return
            }
            do {
                try self?.context.save()
                promise(.success(true))
            } catch {
                promise(.failure(.dataBaseError(message: error.localizedDescription)))
            }
        }.eraseToAnyPublisher()
    }
    
    func delete<DataType>(data: DataType) -> AnyPublisher<Bool, NCError> where DataType : Storable {
        return Future<Bool, NCError> { [weak self] promise in
            guard let self = self else {
                promise(.failure(NCError.dataBaseError(message: "Found null for shared instance.")))
                return
            }
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: DataType.descriptor)
            request.predicate = NSPredicate(format: "uuid == %@", data.uuid as CVarArg)
            do {
                if let result = try self.context.fetch(request).first as? NSManagedObject {
                    self.context.delete(result)
                    promise(.success(true))
                }
                promise(.failure(.dataBaseError(message: "Could not find data with uuid: \(data.uuid) in the database")))
            } catch {
                promise(.failure(.dataBaseError(message: error.localizedDescription)))
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteDatabase(for entity: String) -> AnyPublisher<Bool, NCError> {
        return Future<Bool, NCError> { [weak self] promise in
            guard let self = self else {
                promise(.failure(NCError.dataBaseError(message: "Found null for shared instance.")))
                return
            }
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            do {
                try self.context.execute(batchDeleteRequest)
                self.save().sink(receiveCompletion: { result in
                    switch result {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }, receiveValue: { value in
                    promise(.success(value))
                }).store(in: &self.cancellables)
            } catch {
                promise(.failure(.dataBaseError(message: error.localizedDescription)))
            }
        }.eraseToAnyPublisher()
    }
    
    func resetDatabase() {
        context.reset()
    }
    
    deinit {
        cancellables.forEach({ $0.cancel() })
        cancellables.removeAll()
    }
}
