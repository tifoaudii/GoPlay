//
//  MainAppViewController.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 29/06/21.
//

import UIKit

final class MainAppViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabView()
    }
    
    private func configureTabView() {
        view.backgroundColor = .white
        viewControllers = createViewControllers()
        tabBar.backgroundColor = .white
    }
    
    private func createViewControllers() -> [UIViewController] {
        let movieListViewController = createMovieListViewController()
        let searchMovieViewController = createSearchMovieViewController()
        return [movieListViewController, searchMovieViewController]
    }
    
    private func createMovieListViewController() -> UINavigationController {
        let dataQuery = MovieDataQuery(
            networkService: MovieNetworkService(),
            localRepository: MovieLocalRepository()
        )
        
        let interactor = MovieListDefaultInteractor(
            dataQuery: dataQuery
        )
        
        let viewModel = MovieListDefaultViewModel(
            interactor: interactor
        )
        
        let viewController: MovieListViewController = MovieListViewController(
            viewModel: viewModel
        )
        
        let movieListItemBar: UITabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        viewController.tabBarItem = movieListItemBar
        return UINavigationController(rootViewController: viewController)
    }
    
    private func createSearchMovieViewController() -> UINavigationController {
        let viewController: SearchMovieViewController = SearchMovieViewController()
        let searchMovieItemBar: UITabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        viewController.tabBarItem = searchMovieItemBar
        return UINavigationController(rootViewController: viewController)
    }
}

