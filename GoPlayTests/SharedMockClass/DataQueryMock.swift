//
//  DataQueryMock.swift
//  GoPlayTests
//
//  Created by Tifo Audi Alif Putra on 01/07/21.
//

@testable import GoPlay
import Foundation

final class DataQueryMock: DataQuery {
    
    // MARK: - Static mock data
    static let mockData: MoviesResponse = MoviesResponse(
        page: 1, totalResults: 10, totalPages: 10, results: [Movie(id: 1, title: "Mock Movie Title", backdropPath: nil, posterPath: nil, overview: "Mock overview", voteAverage: 8, voteCount: 8, tagline: nil, genres: [], videos: nil, credits: nil, adult: false, runtime: nil)])
    
    static let mockError: ErrorResponse = .apiError
    
    private let testScenario: TestScenario
    
    init(testScenario: TestScenario) {
        self.testScenario = testScenario
    }
    
    var fetchMoviesCalled = false
    var loadMoviesCalled = false
    var searchMovieCalled = false
    
    enum TestScenario {
        case success
        case failed
    }
    
    func fetchMovies(for endpoint: MovieEndpoint, success: @escaping (MoviesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        fetchMoviesCalled = true
        
        if testScenario == .success {
            success(DataQueryMock.mockData)
        } else {
            failure(DataQueryMock.mockError)
        }
    }
    
    func loadMovies(for endpoint: MovieEndpoint, success: @escaping ([Movie]) -> Void) {
        loadMoviesCalled = true
    }
    
    func searchMovie(query: String, success: @escaping (MoviesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        searchMovieCalled = true
    }
}
