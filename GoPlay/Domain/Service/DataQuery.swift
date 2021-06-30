//
//  NetworkService.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 29/06/21.
//

import Foundation

protocol DataQuery {
    func fetchHero(for endpoint: MovieEndpoint, success: @escaping (MoviesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func loadHero(for endpoint: MovieEndpoint, success: @escaping ([Movie]) -> Void)
}

final class MovieDataQuery: DataQuery {
    
    private let networkService: NetworkService
    private let localRepository: LocalRepository
    
    init(networkService: NetworkService, localRepository: LocalRepository) {
        self.networkService = networkService
        self.localRepository = localRepository
    }
    
    func fetchHero(for endpoint: MovieEndpoint, success: @escaping (MoviesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        networkService.fetchMovie(for: endpoint) { [weak self] (response: MoviesResponse) in
            
            self?.localRepository.save(key: endpoint, movies: response.results)
            
            DispatchQueue.main.async {
                success(response)
            }
            
        } failure: { (error: ErrorResponse) in
            DispatchQueue.main.async {
                failure(error)
            }
        }
    }
    
    func loadHero(for endpoint: MovieEndpoint, success: @escaping ([Movie]) -> Void) {
        localRepository.load(key: endpoint) { (movies: [Movie]) in
            success(movies)
        }
    }
}
