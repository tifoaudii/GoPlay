//
//  MovieListViewModelTest.swift
//  GoPlayTests
//
//  Created by Tifo Audi Alif Putra on 30/06/21.
//

@testable import GoPlay
import XCTest

final class MovieListViewModelTest: XCTestCase {
    
    // MARK: - Static mock data
    static let mockData: [MovieEndpoint : [Movie]] = [
        .nowPlaying : [Movie(id: 1, title: "Mock Movie Title", backdropPath: nil, posterPath: nil, overview: "Mock overview", voteAverage: 8, voteCount: 8, tagline: nil, genres: [], videos: nil, credits: nil, adult: false, runtime: nil)],
        .popular: [Movie(id: 2, title: "Mock Movie Title", backdropPath: nil, posterPath: nil, overview: "Mock overview", voteAverage: 8, voteCount: 8, tagline: nil, genres: [], videos: nil, credits: nil, adult: false, runtime: nil)],
        .topRated: [Movie(id: 3, title: "Mock Movie Title", backdropPath: nil, posterPath: nil, overview: "Mock overview", voteAverage: 8, voteCount: 8, tagline: nil, genres: [], videos: nil, credits: nil, adult: false, runtime: nil)],
        .upcoming: [Movie(id: 4, title: "Mock Movie Title", backdropPath: nil, posterPath: nil, overview: "Mock overview", voteAverage: 8, voteCount: 8, tagline: nil, genres: [], videos: nil, credits: nil, adult: false, runtime: nil)]
    ]
    
    static let mockError: ErrorResponse = .apiError
    
    enum TestScenario {
        case success
        case failed
    }

    // MARK: - Mock
    final class MovieListInteractorMock: MovieListInteractor {
        
        private let testScenario: TestScenario
        
        init(testScenario: TestScenario) {
            self.testScenario = testScenario
        }
        
        var moviesDictionary: [MovieEndpoint : [Movie]] = [:]
        var error: ErrorResponse?
        
        var fetchMoviesCalled = false
        var loadMoviesCalled = false
        
        func fetchMovies(onSuccess: @escaping ([MovieEndpoint : [Movie]]) -> Void, onFailure: @escaping (Error) -> Void) {
            fetchMoviesCalled = true
            
            if testScenario == .success {
                onSuccess(mockData)
            } else {
                onFailure(mockError)
            }
        }
        
        func loadMovies(onSuccess: @escaping ([MovieEndpoint : [Movie]]) -> Void) {
            loadMoviesCalled = true
        }
    }
    
    // MARK: - Testcases
    
    func testViewModelShouldAskInteractorToFetchMovies() {
        // Given
        let mockInteractor = MovieListInteractorMock(testScenario: .success)
        let viewModel = MovieListDefaultViewModel(interactor: mockInteractor)
        
        // When
        viewModel.fetchMovies()
        
        // Then
        XCTAssert(mockInteractor.fetchMoviesCalled)
    }
    
    func testViewModelShouldAskInteractorToLoadMovies() {
        // Given
        let mockInteractor = MovieListInteractorMock(testScenario: .success)
        let viewModel = MovieListDefaultViewModel(interactor: mockInteractor)
        
        // When
        viewModel.loadMovies()
        
        // Then
        XCTAssert(mockInteractor.loadMoviesCalled)
    }

    
    func testViewModelStateShouldEqualToPopulated() {
        // Given
        let mockInteractor = MovieListInteractorMock(testScenario: .success)
        let viewModel = MovieListDefaultViewModel(interactor: mockInteractor)
        
        // When
        viewModel.fetchMovies()
        
        // Then
        XCTAssertEqual(viewModel.state, .populated)
    }
    
    func testViewModelStateShouldEqualToError() {
        // Given
        let mockInteractor = MovieListInteractorMock(testScenario: .failed)
        let viewModel = MovieListDefaultViewModel(interactor: mockInteractor)
        
        // When
        viewModel.fetchMovies()
        
        // Then
        XCTAssertEqual(viewModel.state, .error)
    }
}
