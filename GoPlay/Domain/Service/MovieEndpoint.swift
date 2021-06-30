//
//  MovieEndpoint.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 29/06/21.
//

import Foundation

public enum MovieEndpoint: String, CustomStringConvertible, CaseIterable {
    case topRated = "top_rated"
    case upcoming
    case popular
    case nowPlaying = "now_playing"
    
    
    public var description: String {
        switch self {
        case .nowPlaying: return "Now Playing"
        case .popular: return "Popular"
        case .topRated: return "Top Rated"
        case.upcoming: return "Upcoming"
        }
    }
}
