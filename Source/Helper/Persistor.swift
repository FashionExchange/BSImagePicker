//
//  Persistor.swift
//  BSGridCollectionViewLayout
//
//  Created by Eugen Spinu on 17/09/2018.
//

import Foundation

enum ModelPersistorKey: String {
    case lastSelectedAssetID
    case lastSelectedAlbumID
}

protocol Persistor {
    func save<T: Codable>(_ model: T, by key: ModelPersistorKey)
    func model<T: Codable>(by key: ModelPersistorKey) -> T?
    func clean(by key: ModelPersistorKey)
}

struct DataModelPersistor: Persistor {
    func save<T: Codable>(_ model: T, by key: ModelPersistorKey) {
        UserDefaults.standard.set(model, forKey: key.rawValue)
    }
    
    func model<T: Codable>(by key: ModelPersistorKey) -> T? {
        return UserDefaults.standard.value(forKey: key.rawValue) as? T
    }
    
    func clean(by key: ModelPersistorKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
