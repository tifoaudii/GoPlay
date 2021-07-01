//
//  SearchMovieViewModel.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 01/07/21.
//

import Foundation

protocol SearchMovieViewModel {
    var onStateChanged: (() -> Void)? { set get }
    var movies: [Movie] { set get }
    var state: ViewState { set get }
    func searchMovie(query: String)
}

final class SearchMovieDefaultViewModel: SearchMovieViewModel {
    
    // MARK:- Private Dependency
    
    private let interactor: SearchMovieInteractor
    
    // MARK:- Initializer
    
    init(interactor: SearchMovieInteractor) {
        self.interactor = interactor
    }
    
    // MARK:- SearchViewModel Implementation
    
    var state: ViewState = .initial {
        didSet {
            DispatchQueue.main.async {
                self.onStateChanged?()
            }
        }
    }
    
    var movies: [Movie] = []
    var onStateChanged: (() -> Void)?
    
    func searchMovie(query: String) {
        state = .request
        
        interactor.searchMovie(query: query) { [weak self] (response: MoviesResponse) in
            self?.movies = response.results
            self?.state = response.results.isEmpty ? .error : .populated
        } failure: { [weak self] (error: ErrorResponse) in
            self?.state = .error
        }
    }
}


