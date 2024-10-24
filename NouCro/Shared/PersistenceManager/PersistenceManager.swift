//
//  PersistenceManager.swift
//  NouCro
//
//  Created by AliReza on 2024-10-23.
//

import UIKit
import CoreData

class PersistenceManager: PersistenceManagerProvider {
    
    static let shared: PersistenceManagerProvider = PersistenceManager()
    
    private let context: NSManagedObjectContext
    
    private init() {
        let container = NSPersistentContainer(name: "NouCroModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error {
                fatalError(error.localizedDescription)
            }
        }
        self.context = container.viewContext
    }
    
    func get<DataType>(onCompletion: @escaping (Result<DataType, any Error>) -> Void) where DataType : Storable {
        return
    }
    
    func getAll<DataType>(onCompletion: @escaping (Result<[DataType], any Error>) -> Void) where DataType : Storable {
        return
    }
    
    func save<DataType>(data: DataType) -> Bool where DataType : Storable {
        return false
    }
    
    func delete<DataType>(data: DataType) -> Bool where DataType : Storable {
        return false
    }
    
    func update<DataType>(data: DataType) -> Bool where DataType : Storable {
        return false
    }
    
    func deleteDataBase() -> Bool {
        return false
    }
    
    
}
