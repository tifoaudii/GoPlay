//
//  MovieListInteractorTest.swift
//  GoPlayTests
//
//  Created by Tifo Audi Alif Putra on 30/06/21.
//

@testable import GoPlay
import XCTest

final class MovieListInteractorTest: XCTestCase {
    
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
