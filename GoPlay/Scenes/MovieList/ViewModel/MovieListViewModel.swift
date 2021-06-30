//
//  MovieListViewModel.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 29/06/21.
//

import Foundation

enum ViewState {
    case initial
    case request
    case error
    case populated
}

protocol MovieListViewModel {
    var onStateChanged: (() -> Void)? { set get }
    var moviesDictionary: [MovieEndpoint : [Movie]] { set get }
    var state: ViewState { set get }
    
    func fetchMovies()
    func loadMovies()
}

final class MovieListDefaultViewModel: MovieListViewModel {
    
    var moviesDictionary: [MovieEndpoint : [Movie]] = [:]
    
    var state: ViewState = .initial {
        didSet {
            onStateChanged?()
        }
    }
    
    var onStateChanged: (() -> Void)?
    
    private let interactor: MovieListInteractor
    
    init(interactor: MovieListInteractor) {
        self.interactor = interactor
    }
    
    func fetchMovies() {
        state = .request
        
        interactor.fetchMovies { (movieDictionary: [MovieEndpoint: [Movie]]) in
            self.moviesDictionary = movieDictionary
            self.state = .populated
        } onFailure: { [weak self] (_) in
            self?.state = .error
        }
    }
    
    func loadMovies() {
        
    }
}
