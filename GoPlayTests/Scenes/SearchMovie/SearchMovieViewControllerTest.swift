//
//  SearchMovieViewControllerTest.swift
//  GoPlayTests
//
//  Created by Tifo Audi Alif Putra on 01/07/21.
//

@testable import GoPlay
import XCTest

class SearchMovieViewControllerTest: XCTestCase {
    
    // MARK: - System under test
    var window: UIWindow!
    var viewController: SearchMovieViewController!

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

    // MARK:- Mock
    
    final class SearchMovieViewModelMock: SearchMovieViewModel {
        
        var onNetworkUnreachable: (() -> Void)?
        var onStateChanged: (() -> Void)?
        var movies: [Movie] = []
        var state: ViewState = .initial
        
        var searchMovieCalled = false
        var startNetworkMonitoringCalled = false
        var stopNetworkMonitoringCalled = false
        
        func searchMovie(query: String) {
            searchMovieCalled = true
        }
        
        func startNetworkMonitoring() {
            startNetworkMonitoringCalled = true
        }
        
        func stopNetworkMonitoring() {
            stopNetworkMonitoringCalled = true
        }
    }
    
    // MARK:- Testcases
    
    func testViewControllerShouldAskViewModelToSearchMovie() {
        // Given
        let mockViewModel = SearchMovieViewModelMock()
        viewController = SearchMovieViewController(viewModel: mockViewModel)
        
        // When
        loadView()
        viewController.searchMovie(query: "Captain Marvel")
        
        // Then
        XCTAssert(mockViewModel.searchMovieCalled)
    }
    
    func testViewModelShouldNotSearchMovieWhenQueryIsEmpty() {
        // Given
        let mockViewModel = SearchMovieViewModelMock()
        viewController = SearchMovieViewController(viewModel: mockViewModel)
        
        // When
        loadView()
        viewController.searchMovie(query: "")
        
        // Then
        XCTAssert(!mockViewModel.searchMovieCalled)
    }
}
