//
//  NetworkService.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 29/06/21.
//

import Foundation

protocol DataQuery {
    func fetchMovies(for endpoint: MovieEndpoint, success: @escaping (MoviesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
    func loadMovies(for endpoint: MovieEndpoint, success: @escaping ([Movie]) -> Void)
}

final class MovieDataQuery: DataQuery {
    
    // MARK:- Dependencies
    
    private let networkService: NetworkService
    private let localRepository: LocalRepository
    
    // MARK:- Initializer
    
    init(networkService: NetworkService, localRepository: LocalRepository) {
        self.networkService = networkService
        self.localRepository = localRepository
    }
    
    // MARK:- DataQuery Protocol Implementation
    
    func fetchMovies(for endpoint: MovieEndpoint, success: @escaping (MoviesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
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
    
    func loadMovies(for endpoint: MovieEndpoint, success: @escaping ([Movie]) -> Void) {
        localRepository.load(key: endpoint) { (movies: [Movie]) in
            success(movies)
        }
    }
}
