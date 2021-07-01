//
//  SearchMovieInteractorTest.swift
//  GoPlayTests
//
//  Created by Tifo Audi Alif Putra on 01/07/21.
//

@testable import GoPlay
import XCTest

class SearchMovieInteractorTest: XCTestCase {

    // MARK: - Testcases
    func testInteractorShouldAskDataQueryToSearchMovies() {
        // Given
        let mockDataQuery = DataQueryMock(testScenario: .success)
        let interactor = SearchMovieDefaultInteractor(dataQuery: mockDataQuery)
        
        // When
        interactor.searchMovie(query: "Captain Marvel") { _ in
            mockDataQuery.searchMovieCalled = true
        } failure: { _ in }
    }
    
    
    func testInteractorSearchMovieResultShouldNotEmpty() {
        // Given
        let mockDataQuery = DataQueryMock(testScenario: .success)
        let interactor = SearchMovieDefaultInteractor(dataQuery: mockDataQuery)
        
        // When
        interactor.searchMovie(query: "Captain Marvel") { (response: MoviesResponse) in
            XCTAssert(!response.results.isEmpty)
        } failure: { _ in }
    }
    

}
