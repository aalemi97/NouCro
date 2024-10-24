//
//  PersistenceManagerProvider.swift
//  NouCro
//
//  Created by AliReza on 2024-10-23.
//

import Foundation

protocol PersistenceManagerProvider {
    func get<DataType: Storable>(onCompletion: @escaping (Result<DataType, Error>) -> Void)
    func getAll<DataType: Storable>(onCompletion: @escaping (Result<[DataType], Error>) -> Void)
    @discardableResult func save<DataType: Storable>(data: DataType) -> Bool
    @discardableResult func delete<DataType: Storable>(data: DataType) -> Bool
    @discardableResult func update<DataType: Storable>(data: DataType) -> Bool
    @discardableResult func deleteDataBase() -> Bool
}
