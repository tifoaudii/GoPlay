//
//  DataQueryTest.swift
//  GoPlayTests
//
//  Created by Tifo Audi Alif Putra on 30/06/21.
//

@testable import GoPlay
import XCTest

class DataQueryTest: XCTestCase {

    // MARK: - Mocks
    final class NetworkServiceMock: NetworkService {
        
        var fetchMovieCalled = false
        var searchMovieCalled = false
        
        func fetchMovie(for endpoint: MovieEndpoint, success: @escaping (MoviesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
            fetchMovieCalled = true
        }
        
        func searchMovie(query: String, success: @escaping (MoviesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
            searchMovieCalled = true
        }
    }
    
    final class LocalRepositoryMock: LocalRepository {
        
        var saveCalled = false
        var loadCalled = false
        
        func save(key: MovieEndpoint, movies: [Movie]) {
            saveCalled = true
        }
        
        func load(key: MovieEndpoint, onSuccess: @escaping ([Movie]) -> Void) {
            loadCalled = true
        }
    }
    
    // MARK: - Testcases
    
    func testDataQueryShouldAskNetworkServiceToFetchMovie() {
        // Given
        let mockNetworkService = NetworkServiceMock()
        let mockLocalRepository = LocalRepositoryMock()
        
        let dataQuery = MovieDataQuery(networkService: mockNetworkService, localRepository: mockLocalRepository)
        
        // When
        dataQuery.fetchMovies(for: .nowPlaying) { _ in
            XCTAssert(mockNetworkService.fetchMovieCalled)
        } failure: { _ in }
    }

    func testDataQueryShouldAskLocalRepositoryToLoadMovie() {
        // Given
        let mockNetworkService = NetworkServiceMock()
        let mockLocalRepository = LocalRepositoryMock()
        
        let dataQuery = MovieDataQuery(networkService: mockNetworkService, localRepository: mockLocalRepository)
        
        // When
        dataQuery.loadMovies(for: .nowPlaying) { _ in
            XCTAssert(mockLocalRepository.loadCalled)
        }
    }
    
    func testDataQueryShouldAskLocalRepositoryToSaveMovie() {
        // Given
        let mockNetworkService = NetworkServiceMock()
        let mockLocalRepository = LocalRepositoryMock()
        
        let dataQuery = MovieDataQuery(networkService: mockNetworkService, localRepository: mockLocalRepository)
        
        // When
        dataQuery.fetchMovies(for: .nowPlaying) { _ in
            XCTAssert(mockLocalRepository.saveCalled)
        } failure: { _ in }
    }
}
