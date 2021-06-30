//
//  NetworkService.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 29/06/21.
//

import Foundation

protocol DataQuery {
    func fetchHero(for endpoint: MovieEndpoint, success: @escaping (MoviesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

final class MovieDataQuery: DataQuery {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchHero(for endpoint: MovieEndpoint, success: @escaping (MoviesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        networkService.fetchMovie(for: endpoint) { (response: MoviesResponse) in
            DispatchQueue.main.async {
                success(response)
            }
        } failure: { (error: ErrorResponse) in
            DispatchQueue.main.async {
                failure(error)
            }
        }
    }
}
