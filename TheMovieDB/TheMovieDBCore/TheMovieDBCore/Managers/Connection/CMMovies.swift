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
}

struct CMMoviesJSONKeys {
    
    static let results = "results"
}

extension ConnectionManager {
    
    public func requestDiscoverMovies(_ handler: @escaping (Result<[Movie]>) -> Swift.Void ) {
        
        request(URI: CMMoviesConstants.URIDiscoverMovies) { data, response, error in
            
            guard let data = data, error == nil else {
                
                handler(.Failure(error ?? TheMovieDBError.unkwnon))
                return
            }
            
            var movies: [Movie] = []
            
            guard let dictionary = data.toJSON(),
                let results = dictionary[CMMoviesJSONKeys.results] as? [AnyObject] else {
                    
                    handler(.Failure(TheMovieDBError.missingKey))
                    return
            }
            
            for item in results {
                
                if let data = item as? [String: AnyObject] {
                    
                    dump(data)
                }
            }
            
            handler(.Success([]))
        }
    }
    
}
