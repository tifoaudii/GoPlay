//
//  ViewController.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 29/06/21.
//

import UIKit
import SwiftMessages

final class MovieListViewController: UITableViewController, ViewMessages {
    
    // MARK: - Dependency
    
    private var viewModel: MovieListViewModel? = nil
    
    // MARK: - Initializer
    
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - View Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindViewModel()
        fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startNetworkMonitoring()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopNetworkMonitoring()
    }
    
    // MARK: - Private functions
    
    private func startNetworkMonitoring() {
        viewModel?.startNetworkMonitoring()
    }
    
    private func stopNetworkMonitoring() {
        viewModel?.stopNetworkMonitoring()
    }
    
    private func fetchMovies() {
        viewModel?.fetchMovies()
    }
    
    private func bindViewModel() {
        viewModel?.onStateChanged = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel?.onNetworkUnreachable = { [weak self] in
            self?.showMessage(message: "Oops, you are offline")
            
            if let state = self?.viewModel?.state, state != .populated {
                self?.viewModel?.loadMovies()
            }
        }
    }
    
    private func configureView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = "Movies"
        tableView.register(TopRatedMovieCollectionCell.self, forCellReuseIdentifier: TopRatedMovieCollectionCell.identifier)
        tableView.register(UpcomingMovieCollectionCell.self, forCellReuseIdentifier: UpcomingMovieCollectionCell.identifier)
        tableView.register(PopularMovieCollectionCell.self, forCellReuseIdentifier: PopularMovieCollectionCell.identifier)
        tableView.register(NowPlayingMovieCollectionCell.self, forCellReuseIdentifier: NowPlayingMovieCollectionCell.identifier)
        tableView.register(RequestStateCell.self, forCellReuseIdentifier: RequestStateCell.identifier)
        tableView.register(ErrorStateCell.self, forCellReuseIdentifier: ErrorStateCell.identifier)
        tableView.tableFooterView = UIView()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource Implementation

extension MovieListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let state = viewModel?.state, state == .populated else {
            return 1
        }
        
        return MovieEndpoint.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel?.state {
        case .request, .initial:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RequestStateCell.identifier, for: indexPath) as? RequestStateCell else {
                return UITableViewCell()
            }
            
            return cell
        case .error:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ErrorStateCell.identifier, for: indexPath) as? ErrorStateCell else {
                return UITableViewCell()
            }
            
            cell.onReload = { [weak self] in
                self?.viewModel?.fetchMovies()
            }
            
            return cell
        case .populated:
            let section = MovieEndpoint.allCases[indexPath.section]
            switch section {
            case .topRated:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TopRatedMovieCollectionCell.identifier, for: indexPath) as? TopRatedMovieCollectionCell else {
                    return UITableViewCell()
                }
                
                cell.addMovies(movies: viewModel?.moviesDictionary[.topRated] ?? [])
                return cell
            case .upcoming:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingMovieCollectionCell.identifier, for: indexPath) as? UpcomingMovieCollectionCell else {
                    return UITableViewCell()
                }
                
                cell.addMovies(movies: viewModel?.moviesDictionary[.upcoming] ?? [])
                return cell
            case .popular:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularMovieCollectionCell.identifier, for: indexPath) as? PopularMovieCollectionCell else {
                    return UITableViewCell()
                }
                
                cell.addMovies(movies: viewModel?.moviesDictionary[.popular] ?? [])
                return cell
            case .nowPlaying:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: NowPlayingMovieCollectionCell.identifier, for: indexPath) as? NowPlayingMovieCollectionCell else {
                    return UITableViewCell()
                }
                
                cell.addMovies(movies: viewModel?.moviesDictionary[.nowPlaying] ?? [])
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel?.state {
        case .request, .error, .initial:
            return tableView.bounds.height - 50
        default:
            let section = MovieEndpoint.allCases[indexPath.section]
            switch section {
            case .topRated, .popular:
                return 220
            case .upcoming:
                return 450
            case .nowPlaying:
                return 140
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch viewModel?.state {
        case .request, .error, .initial:
            return UIView()
        default:
            let view = UIView(frame: .init(x: 0, y: 0, width: tableView.frame.width, height: 40))
            view.backgroundColor = .white
            let headerLabel = UILabel(frame: CGRect(x: 16, y: 0, width: view.frame.width, height: view.frame.height))
            headerLabel.text = MovieEndpoint.allCases[section].description
            headerLabel.font = .systemFont(ofSize: 16, weight: .heavy)
            view.addSubview(headerLabel)
            return view
        }
    }
}

