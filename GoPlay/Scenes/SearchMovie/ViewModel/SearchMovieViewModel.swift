//
//  SearchMovieViewModel.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 01/07/21.
//

import Foundation
import Reachability

protocol SearchMovieViewModel {
    var onStateChanged: (() -> Void)? { set get }
    var movies: [Movie] { set get }
    var state: ViewState { set get }
    var onNetworkUnreachable: (() -> Void)? { set get }
    
    func searchMovie(query: String)
    func startNetworkMonitoring()
    func stopNetworkMonitoring()
}

final class SearchMovieDefaultViewModel: SearchMovieViewModel {
    
    // MARK:- Private Dependency
    
    private let interactor: SearchMovieInteractor
    private var reachability: Reachability?
    
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
    var onNetworkUnreachable: (() -> Void)?
    
    func searchMovie(query: String) {
        state = .request
        
        interactor.searchMovie(query: query) { [weak self] (response: MoviesResponse) in
            self?.movies = response.results
            self?.state = response.results.isEmpty ? .empty : .populated
        } failure: { [weak self] (error: ErrorResponse) in
            self?.state = .error
        }
    }
    
    func startNetworkMonitoring() {
        reachability = try? Reachability()
        
        do {
            try? reachability?.startNotifier()
        }
        
        reachability?.whenUnreachable = { [weak self] _ in
            self?.onNetworkUnreachable?()
        }
    }
    
    func stopNetworkMonitoring() {
        reachability?.stopNotifier()
        reachability = nil
    }
}


