//
//  LocalRepository.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 29/06/21.
//

import Foundation

protocol LocalRepository {
    func save(key: MovieEndpoint, movies: [Movie])
    func load(key: MovieEndpoint, onSuccess: @escaping ([Movie]) -> Void)
}

final class MovieLocalRepository: LocalRepository {
    
    private let localStorage: LocalStorage = LocalStorage.shared(suiteName: "goplay-local-storage")
    
    func save(key: MovieEndpoint, movies: [Movie]) {
        localStorage.save(key: key.rawValue, data: movies)
    }
    
    func load(key: MovieEndpoint, onSuccess: @escaping ([Movie]) -> Void) {
        localStorage.get(key: key.rawValue, onSuccess: onSuccess)
    }
}
