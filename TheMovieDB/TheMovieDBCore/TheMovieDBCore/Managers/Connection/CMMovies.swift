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
    static let URIGenre = "genre/movie/list"
    
    static let URLParamPage = "page"
    
    static let JSONGenreList = "genres"
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
    
    public func requestGenre(handler: @escaping (Result<[MovieGenre]>) -> Swift.Void ) {
        
        request(URI: CMMoviesConstants.URIGenre) { data, response, error in
            
                    
            guard let data = data, error == nil else {
                
                handler(.Failure(error ?? TheMovieDBError.unkwnon))
                return
            }
                    
            guard let dictionary = data.toJSON() else {
                
                handler(.Failure(TheMovieDBError.JSONParseFailed(reason: "")))
                return
            }
            
            guard let content = dictionary[CMMoviesConstants.JSONGenreList] as? Array<AnyObject> else {
                        
                handler(.Failure(TheMovieDBError.missingKey))
                return
            }
            
            var result: [MovieGenre] = []
            
            for item in content {
                
                if let data = item as? [String: AnyObject] {
                    
                    if let genre = MovieGenre(data: data) {
                        
                        result.append(genre)
                    }
                }
            }
            
            handler(.Success(result))
        }
    }
    
}
