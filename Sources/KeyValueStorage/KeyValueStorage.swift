//
//  KeyValueStorage.swift
//  Dependencies
//
//  Created by Татьяна Макеева on 16.04.2025.
//

import Foundation
import SwiftUI
import Combine
import OSLog

public protocol KeyValueStorage: Sendable {
    func set<T: Codable>(_ value: T, forKey key: String) throws
    func object<T: Codable>(forKey key: String) throws -> T?
    func removeObject(forKey key: String) throws
}

public struct KeyValueStorageMock: KeyValueStorage {
    public init() {}
    
    public  func set<T: Codable>(_ value: T, forKey key: String) throws {
        
    }
    
    public func object<T: Codable>(forKey key: String) throws -> T? {
        nil
    }
    
    public func removeObject(forKey key: String) throws {
        
    }
}

