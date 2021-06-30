//
//  MovieListInteractorTest.swift
//  GoPlayTests
//
//  Created by Tifo Audi Alif Putra on 30/06/21.
//

@testable import GoPlay
import XCTest

final class MovieListInteractorTest: XCTestCase {
    
    // MARK: - Static mock data
    static let mockData: MoviesResponse = MoviesResponse(
        page: 1, totalResults: 10, totalPages: 10, results: [Movie(id: 1, title: "Mock Movie Title", backdropPath: nil, posterPath: nil, overview: "Mock overview", voteAverage: 8, voteCount: 8, tagline: nil, genres: [], videos: nil, credits: nil, adult: false, runtime: nil)])
    
    static let mockError: ErrorResponse = .apiError
    
    // MARK: - Mock
    final class DataQueryMock: DataQuery {
        
        private let testScenario: TestScenario
        
        init(testScenario: TestScenario) {
            self.testScenario = testScenario
        }
        
        var fetchMoviesCalled = false
        var loadMoviesCalled = false
        
        enum TestScenario {
            case success
            case failed
        }
        
        func fetchMovies(for endpoint: MovieEndpoint, success: @escaping (MoviesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
            fetchMoviesCalled = true
            
            if testScenario == .success {
                success(mockData)
            } else {
                failure(mockError)
            }
        }
        
        func loadMovies(for endpoint: MovieEndpoint, success: @escaping ([Movie]) -> Void) {
            loadMoviesCalled = true
        }
    }
    
    // MARK: - Testcases
    func testInteractorShouldAskDataQueryToFetchMovies() {
        // Given
        let mockDataQuery = DataQueryMock(testScenario: .success)
        let interactor = MovieListDefaultInteractor(dataQuery: mockDataQuery)
        
        // When
        interactor.fetchMovies { (_) in
            XCTAssert(mockDataQuery.fetchMoviesCalled)
        } onFailure: { _ in }
    }
    
    func testInteractorShouldAskDataQueryToLoadMovies() {
        // Given
        let mockDataQuery = DataQueryMock(testScenario: .success)
        let interactor = MovieListDefaultInteractor(dataQuery: mockDataQuery)
        
        // When
        interactor.loadMovies { (_) in
            XCTAssert(mockDataQuery.loadMoviesCalled)
        }
    }
    
    func testInteractorMovieDictionaryShouldNotEmpty() {
        // Given
        let mockDataQuery = DataQueryMock(testScenario: .success)
        let interactor = MovieListDefaultInteractor(dataQuery: mockDataQuery)
        
        // When
        interactor.fetchMovies { (movieDictionary: [MovieEndpoint: [Movie]]) in
            XCTAssert(!movieDictionary.isEmpty)
        } onFailure: { _ in }
    }
}
