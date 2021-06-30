//
//  MovieListInteractor.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 29/06/21.
//

import Foundation

protocol MovieListInteractor {
    var moviesDictionary: [MovieEndpoint : [Movie]] { set get }
    var error: ErrorResponse? { set get }
    
    func fetchMovies(onSuccess: @escaping ([MovieEndpoint : [Movie]]) -> Void, onFailure: @escaping (Error) -> Void)
    func loadMovies(onSuccess: @escaping ([MovieEndpoint : [Movie]]) -> Void)
}

final class MovieListDefaultInteractor: MovieListInteractor {
    
    private let dataQuery: DataQuery
    
    var moviesDictionary: [MovieEndpoint : [Movie]] = [:]
    var error: ErrorResponse? = nil
    
    init(dataQuery: DataQuery) {
        self.dataQuery = dataQuery
    }
    
    func fetchMovies(onSuccess: @escaping ([MovieEndpoint : [Movie]]) -> Void, onFailure: @escaping (Error) -> Void) {
        let dispatchQueue = DispatchQueue(
            label: "goplay.movies.interactor",
            qos: .userInitiated,
            attributes: .concurrent
        )
        
        let dispatchGroup = DispatchGroup()
        let dispatchSemaphore = DispatchSemaphore(value: MovieEndpoint.allCases.count)
        
        dispatchQueue.async(group: dispatchGroup) { [weak self] in
            
            dispatchSemaphore.wait()
            
            MovieEndpoint.allCases.forEach { [weak self] (endpoint: MovieEndpoint) in
                dispatchGroup.enter()
                self?.dataQuery.fetchHero(for: endpoint) { (response: MoviesResponse) in
                    self?.moviesDictionary[endpoint] = response.results
                    dispatchGroup.leave()
                } failure: { (error: ErrorResponse) in
                    self?.error = error
                    dispatchGroup.leave()
                }
            }
            
            dispatchSemaphore.signal()
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else {
                return
            }
        
            guard let error = self.error else {
                return onSuccess(self.moviesDictionary)
            }
            
            onFailure(error)
        }
    }
    
    func loadMovies(onSuccess: @escaping ([MovieEndpoint : [Movie]]) -> Void) {
        MovieEndpoint.allCases.forEach { [weak self] (endpoint: MovieEndpoint) in
            self?.dataQuery.loadHero(for: endpoint, success: { (movies: [Movie]) in
                self?.moviesDictionary[endpoint] = movies
            })
        }
        
        onSuccess(self.moviesDictionary)
    }
}
