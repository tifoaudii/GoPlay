//
//  SearchMovieViewController.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 29/06/21.
//

import UIKit

final class SearchMovieViewController: UIViewController {
    
    // MARK:-  UI Components
    
    private lazy var searchView: SearchView = {
        let searchView = SearchView()
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        searchView.layer.borderWidth = 0.5
        searchView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return searchView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.register(SearchMovieResultCell.self, forCellReuseIdentifier: SearchMovieResultCell.identifier)
        tableView.register(RequestStateCell.self, forCellReuseIdentifier: RequestStateCell.identifier)
        tableView.register(ErrorStateCell.self, forCellReuseIdentifier: ErrorStateCell.identifier)
        return tableView
    }()
    
    // MARK:- Private Property & Dependency
    
    private var viewModel: SearchMovieViewModel? = nil
    private var searchQuery: String = ""
    
    // MARK:- Initializer
    
    init(viewModel: SearchMovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK:- View Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindSearchView()
        bindViewModel()
    }
    
    // MARK:- Private functions
    
    private func bindViewModel() {
        viewModel?.onStateChanged = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func bindSearchView() {
        searchView.onSearch = { [weak self] (query: String) in
            guard let viewModel = self?.viewModel, viewModel.state != .request, !query.isEmpty else {
                return
            }
            
            self?.searchQuery = query
            self?.searchMovie(query: query)
        }
    }
    
    private func configureView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = "Search Movies"
        navigationController?.navigationBar.isTranslucent = false
        
        let stackView = UIStackView(
            arrangedSubviews: [
                searchView,
                tableView
            ]
        )
        .setAxis(.vertical)
        
        view.addSubview(stackView)
        stackView.fillSuperview()
    }
    
    private func searchMovie(query: String) {
        viewModel?.searchMovie(query: query)
    }
}

// MARK:- UITableViewDelegate & UITableViewDataSource Implementation

extension SearchMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel?.state {
        case .request:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RequestStateCell.identifier, for: indexPath) as? RequestStateCell else {
                return UITableViewCell()
            }
            
            return cell
        case .error:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ErrorStateCell.identifier, for: indexPath) as? ErrorStateCell else {
                return UITableViewCell()
            }
            
            cell.onReload = { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.searchMovie(query: self.searchQuery)
            }
            
            return cell
        case .populated:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchMovieResultCell.identifier, for: indexPath) as? SearchMovieResultCell else {
                return UITableViewCell()
            }
            
            guard let movie = viewModel?.movies[indexPath.row] else {
                return UITableViewCell()
            }
            
            cell.bindViewWith(movie: movie)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel?.state == .populated {
            return viewModel?.movies.count ?? 0
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel?.state == .populated {
            return 140
        }
        
        return tableView.bounds.height - 90
    }
}
