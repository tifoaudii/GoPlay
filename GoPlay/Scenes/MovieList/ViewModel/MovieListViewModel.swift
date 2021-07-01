//
//  MovieListViewModel.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 29/06/21.
//

import Foundation
import Reachability

protocol MovieListViewModel {
    var onStateChanged: (() -> Void)? { set get }
    var onNetworkUnreachable: (() -> Void)? { set get }
    var moviesDictionary: [MovieEndpoint : [Movie]] { set get }
    var state: ViewState { set get }
    
    func fetchMovies()
    func loadMovies()
    func startNetworkMonitoring()
    func stopNetworkMonitoring()
}

final class MovieListDefaultViewModel: MovieListViewModel {
    
    // MARK:- Dependencies
    
    private let interactor: MovieListInteractor
    private var reachability: Reachability?
    
    // MARK:- Initializer
    
    init(interactor: MovieListInteractor) {
        self.interactor = interactor
    }
    
    // MARK:- MovieListViewModel Implementation
    
    var moviesDictionary: [MovieEndpoint : [Movie]] = [:]
    var onNetworkUnreachable: (() -> Void)?
    
    var state: ViewState = .initial {
        didSet {
            DispatchQueue.main.async {
                self.onStateChanged?()
            }
        }
    }
    
    var onStateChanged: (() -> Void)?
    
    func fetchMovies() {
        state = .request
        interactor.fetchMovies { [weak self] (movieDictionary: [MovieEndpoint: [Movie]]) in
            self?.moviesDictionary = movieDictionary
            self?.state = .populated
        } onFailure: { [weak self] (_) in
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
    
    func loadMovies() {
        state = .request
        
        interactor.loadMovies { [weak self] (movieDictionary: [MovieEndpoint : [Movie]]) in
            self?.moviesDictionary = movieDictionary
            self?.state = .populated
        }
    }
}
