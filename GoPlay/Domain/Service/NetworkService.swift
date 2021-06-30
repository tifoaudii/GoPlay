//
//  NetworkService.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 29/06/21.
//

import Foundation

protocol NetworkService {
    func fetchMovie(for endpoint: MovieEndpoint, success: @escaping (MoviesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void)
}

final class MovieNetworkService: NetworkService {
    
    private let baseUrl = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let apiKey = "ae5b867ee790efe19598ff6108ad4e02"
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    func fetchMovie(for endpoint: MovieEndpoint, success: @escaping (MoviesResponse) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        
        guard var urlComponents = URLComponents(string: "\(baseUrl)/movie/\(endpoint.rawValue)") else {
            return failure(.invalidEndpoint)
        }
        
        urlComponents.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        
        guard let url = urlComponents.url else {
            return failure(.invalidEndpoint)
        }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                return failure(.apiError)
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                return failure(.invalidResponse)
            }
            
            guard let data = data else {
                return failure(.noData)
            }
            
            do {
                let movieResponse = try self.jsonDecoder.decode(MoviesResponse.self, from: data)
                DispatchQueue.main.async {
                    success(movieResponse)
                }
            } catch {
                return failure(.serializationError)
            }
        }.resume()
        
    }
}
