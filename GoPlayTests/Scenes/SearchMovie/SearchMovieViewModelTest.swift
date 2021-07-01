//
//  SearchMovieViewModelTest.swift
//  GoPlayTests
//
//  Created by Tifo Audi Alif Putra on 01/07/21.
//

@testable import GoPlay
import XCTest

final class SearchMovieViewModelTest: XCTestCase {

    
    // MARK: - Static mock data
    
    static let mockData: MoviesResponse = MoviesResponse(
        page: 1, totalResults: 10, totalPages: 10, results: [Movie(id: 1, title: "Mock Movie Title", backdropPath: nil, posterPath: nil, overview: "Mock overview", voteAverage: 8, voteCount: 8, tagline: nil, genres: [], videos: nil, credits: nil, adult: false, runtime: nil)])
    
    static let mockError: ErrorResponse = .apiError
    
    enum TestScenario {
        case success
        case failed
    }

    // MARK:- Mock
    
    final class SearchMovieInteractorMock: SearchMovieInteractor {
        
        private let testScenario: TestScenario
        
        init(testScenario: TestScenario) {
            self.testScenario = testScenario
        }
        
        var searchMovieCalled = false
        
        func searchMovie(query: String, success: @escaping (MoviesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
            searchMovieCalled = true
            
            if testScenario == .success {
                success(mockData)
            } else {
                failure(mockError)
            }
        }
    }
    
    // MARK:- Testcases
    
    func testViewModelShouldAskInteractorToSearchMovies() {
        // Given
        let mockInteractor = SearchMovieInteractorMock(testScenario: .success)
        let viewModel = SearchMovieDefaultViewModel(interactor: mockInteractor)
        
        // When
        viewModel.searchMovie(query: "Captain Marvel")
        
        // Then
        XCTAssert(mockInteractor.searchMovieCalled)
    }
    
    func testViewModelStateShouldEqualToPopulated() {
        // Given
        let mockInteractor = SearchMovieInteractorMock(testScenario: .success)
        let viewModel = SearchMovieDefaultViewModel(interactor: mockInteractor)
        
        // When
        viewModel.searchMovie(query: "Captain Marvel")
        
        // Then
        XCTAssertEqual(viewModel.state, .populated)
    }
    
    func testViewModelStateShouldEqualToError() {
        // Given
        let mockInteractor = SearchMovieInteractorMock(testScenario: .failed)
        let viewModel = SearchMovieDefaultViewModel(interactor: mockInteractor)
        
        // When
        viewModel.searchMovie(query: "Captain Marvel")
        
        // Then
        XCTAssertEqual(viewModel.state, .error)
    }
}
