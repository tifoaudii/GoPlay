//
//  MovieListViewControllerTest.swift
//  GoPlayTests
//
//  Created by Tifo Audi Alif Putra on 30/06/21.
//

@testable import GoPlay
import XCTest

final class MovieListViewControllerTest: XCTestCase {
    
    // MARK: - System under test
    var window: UIWindow!
    var viewController: MovieListViewController!
    
    override func setUpWithError() throws {
        window = UIWindow()
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        viewController = nil
        window = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Private function
    private func loadView() {
        window.addSubview(viewController.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - Mock
    final class MovieListViewModelMock: MovieListViewModel {
        
        var onStateChanged: (() -> Void)?
        var onNetworkReachable: (() -> Void)?
        var onNetworkUnreachable: (() -> Void)?
        var moviesDictionary: [MovieEndpoint : [Movie]] = [:]
        var state: ViewState = .initial
        
        var fetchMoviesCalled = false
        var loadMoviesCalled = false
        var startNetworkMonitoringCalled = false
        var stopNetworkMonitoringCalled = false
        
        func fetchMovies() {
            fetchMoviesCalled = true
        }
        
        func loadMovies() {
            loadMoviesCalled = true
        }
        
        func startNetworkMonitoring() {
            startNetworkMonitoringCalled = true
        }
        
        func stopNetworkMonitoring() {
            stopNetworkMonitoringCalled = true
        }
    }
    
    // MARK: - Testcases
    func testViewControllerShouldAskViewModelToFetchMovies() {
        // Given
        let mockViewModel = MovieListViewModelMock()
        viewController = MovieListViewController(viewModel: mockViewModel)
        
        // When
        loadView()
        viewController.viewDidLoad()
        
        // Then
        XCTAssert(mockViewModel.fetchMoviesCalled)
    }
    
    func testViewControllerShouldAskViewModelToStartNetworkMonitoring() {
        // Given
        let mockViewModel = MovieListViewModelMock()
        viewController = MovieListViewController(viewModel: mockViewModel)
        
        // When
        loadView()
        viewController.viewWillAppear(true)
        
        // Then
        XCTAssert(mockViewModel.startNetworkMonitoringCalled)
    }
    
    func testViewControllerShouldAskViewModelToStopNetworkMonitoring() {
        // Given
        let mockViewModel = MovieListViewModelMock()
        viewController = MovieListViewController(viewModel: mockViewModel)
        
        // When
        loadView()
        viewController.viewWillDisappear(true)
        
        // Then
        XCTAssert(mockViewModel.startNetworkMonitoringCalled)
    }
}
