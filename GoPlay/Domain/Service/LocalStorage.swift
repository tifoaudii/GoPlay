//
//  LocalStorage.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 29/06/21.
//

import Foundation

final class LocalStorage {
    
    // MARK:- Properties
    
    private let userDefault: UserDefaults?
    private let suiteName: String?
    
    // MARK:- Initializer
    
    init(suiteName: String?) {
        
        self.suiteName = suiteName
        
        if let name = suiteName {
            userDefault = UserDefaults(suiteName: name)
        } else {
            userDefault = UserDefaults.standard
        }
    }
    
    // MARK:- Static functions
    
    static func shared(suiteName: String? = nil) -> LocalStorage {
        return LocalStorage(suiteName: suiteName)
    }
    
    // MARK:- Internal Functions
    
    func save<T: Codable>(key: String, data: [T], onSuccess: (([T]) -> Void)? = nil, onFailure: ((Error) -> Void)? = nil
    ) {
        
        do {
            let encodedData = try encode(from: data)
            userDefault?.set(encodedData, forKey: key)
            
            onSuccess?(data)
        } catch let error {
            onFailure?(error)
        }
        
    }
    
    
    func get<T: Codable>(key: String, onSuccess: (([T]) -> Void), onFailure: ((Error) -> Void)? = nil) {
        do {
            let data: [T] = try decode(key: key)
            onSuccess(data)
        } catch let error {
            onFailure?(error)
        }
    }
    
    // MARK:- Private functions
    
    private func encode<T: Codable>(from data: T) throws -> String {
        let encoder = JSONEncoder()
        
        do {
            
            let encodedData = try encoder.encode(data)
            let dataStr = String(decoding: encodedData, as: UTF8.self)
            
            return dataStr
        } catch let exception {
            throw exception
        }
    }
    
    private func decode<T: Decodable>(key: String) throws -> T {
        
        let decoder = JSONDecoder()
        
        do {
            
            guard let dataStr = userDefault?.string(forKey: key),
                let data = dataStr.data(using: .utf8) else {
                    throw NSError()
            }
            
            let decodedData = try decoder.decode(T.self, from: data)
            
            return decodedData
        } catch let exception {
            throw exception
        }
    }
    
}
