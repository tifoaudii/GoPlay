//
//  ViewController.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 29/06/21.
//

import UIKit

final class MovieListViewController: UITableViewController {
    
    private var viewModel: MovieListViewModel?
    
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        fetchMovies()
        bindViewModel()
    }
    
    private func fetchMovies() {
        viewModel?.fetchMovies()
    }
    
    private func bindViewModel() {
        viewModel?.onStateChanged = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func configureView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = "Movies & TV"
        tableView.register(TopRatedMovieCollectionCell.self, forCellReuseIdentifier: TopRatedMovieCollectionCell.identifier)
        tableView.register(UpcomingMovieCollectionCell.self, forCellReuseIdentifier: UpcomingMovieCollectionCell.identifier)
        tableView.register(PopularMovieCollectionCell.self, forCellReuseIdentifier: PopularMovieCollectionCell.identifier)
        tableView.register(NowPlayingMovieCollectionCell.self, forCellReuseIdentifier: NowPlayingMovieCollectionCell.identifier)
        tableView.tableFooterView = UIView()
    }
}

extension MovieListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return MovieEndpoint.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel?.state {
        case .request, .initial:
            return UITableViewCell()
        case .error:
            return UITableViewCell()
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
            return 0
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

