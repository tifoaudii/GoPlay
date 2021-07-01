//
//  SearchMovieInteractor.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 01/07/21.
//

import Foundation

protocol SearchMovieInteractor {
    func searchMovie(query: String, success: @escaping (MoviesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

final class SearchMovieDefaultInteractor: SearchMovieInteractor {
    
    // MARK:- Private Dependency
    private let dataQuery: DataQuery
    
    // MARK:- Initializer
    
    init(dataQuery: DataQuery) {
        self.dataQuery = dataQuery
    }
    
    // MARK:- SearchMovieInteractor Implementation
    
    func searchMovie(query: String, success: @escaping (MoviesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        dataQuery.searchMovie(query: query, success: success, failure: failure)
    }
}
