//
//  CMMovies.swift
//  TheMovieDBCore
//
//  Created by Santex on 11/25/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import Foundation

struct CMMoviesConstants {
    
    static let URIDiscoverMovies = "discover/movie"
    static let URLParamPage = "page"
}

struct CMMoviesJSONKeys {
    
}

extension ConnectionManager {
    
    public func requestDiscoverMovies(page: Int, handler: @escaping (Result<MoviePage>) -> Swift.Void ) {
        
        request(URI: CMMoviesConstants.URIDiscoverMovies,
                parameters: [CMMoviesConstants.URLParamPage: "\(page)"]) { data, response, error in
            
            guard let data = data, error == nil else {
                
                handler(.Failure(error ?? TheMovieDBError.unkwnon))
                return
            }
            
            guard let dictionary = data.toJSON() else {
                
                handler(.Failure(TheMovieDBError.JSONParseFailed(reason: "")))
                return
            }
            
            guard let moviePage = MoviePage(data: dictionary) else {
                
                handler(.Failure(TheMovieDBError.missingKey))
                return
            }
            
            handler(.Success(moviePage))
        }
    }
    
}
