//
//  Movie.swift
//  TheMovieDBCore
//
//  Created by Santex on 11/25/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import Foundation

public struct Movie {
    
    var id: Int
    public var title: String
    public var description: String
    public var imageURL: String
    public var genres: [AnyObject]?
    public var releaseDate: Date?
    
    init(id: Int, title: String, description: String, imageURL: String, genres: [AnyObject]?, releaseDate: Date?) {
        
        self.id = id
        self.title = title
        self.description = description
        self.imageURL = imageURL
        self.genres = genres
        self.releaseDate = releaseDate
    }
    
}

//  MARK: Movie+JSON

struct MovieJSONKeys {
    
    static let id = "id"
    static let title = "title"
    static let description = "overview"
    static let imageURL = "poster_path"
    static let genre = "genre_ids"
    static let stringDate = "release_date"
}

extension Movie {
    
    init?(data: [String: Any]) {
        
        guard let id = data[MovieJSONKeys.id] as? Int,
            let title = data[MovieJSONKeys.title] as? String,
            let description = data[MovieJSONKeys.description] as? String,
            let imageURL = data[MovieJSONKeys.imageURL] as? String,
            let stringDate = data[MovieJSONKeys.stringDate] as? String else {
                
                return nil
        }
        
        let releaseDate = Date.from(movieDBFormat: stringDate)
        let genres = data[MovieJSONKeys.genre] as? [AnyObject]
        
        self.init(id: id, title: title, description: description, imageURL: imageURL, genres: genres, releaseDate: releaseDate)
    }
    
}

//  MARK: Movie+CustomPresentation

extension Movie {
    
    public func stringReleaseDate() -> String? {
        
        return self.releaseDate?.toCustomizedDate() ?? ""
    }

}

//  MARK: -

//  MARK: MoviePage

public struct MoviePage {
    
    public var page: Int
    public var totalResults: Int
    public var totalPages: Int
    public var movies: [Movie]?
    
    init(page: Int, totalResults: Int, totalPages: Int, movies: [Movie]?) {
        
        self.page = page
        self.totalResults = totalResults
        self.totalPages = totalPages
        self.movies = movies
    }
    
}

//  MARK: MoviePage+JSON

struct MoviePageJSONKeys {
    
    static let page = "page"
    static let results = "results"
    static let totalResults = "total_results"
    static let totalPages = "total_pages"
}

extension MoviePage {
    
    init?(data: [String: Any]) {
        
        guard let page = data[MoviePageJSONKeys.page] as? Int,
            let totalResults = data[MoviePageJSONKeys.totalResults] as? Int,
            let totalPages = data[MoviePageJSONKeys.totalPages] as? Int else {
                
                return nil
        }
        
        var movies: [Movie]?
        
        if let results = data[MoviePageJSONKeys.results] as? [AnyObject] {
            
            movies = []
            
            for item in results {
                
                if let data = item as? [String: AnyObject] {
                    
                    if let movie = Movie(data: data) {
                        
                        movies?.append(movie)
                    }
                }
            }
        }
        
        self.init(page: page, totalResults: totalResults, totalPages: totalPages, movies: movies)
    }
    
}

//  MARK: -

//  MARK: MovieGenre

public struct MovieGenre {
    
    public var id: Int
    public var name: String
    
    init(id: Int, name: String) {
        
        self.id = id
        self.name = name
    }
    
}

//  MARK: MovieGenre+JSON

struct MovieGenreJSONKeys {
    
    static let id = "id"
    static let name = "name"
}

extension MovieGenre {
    
    init?(data: [String: Any]) {
        
        guard let id = data[MovieGenreJSONKeys.id] as? Int,
            let name = data[MovieGenreJSONKeys.name] as? String else {
                
                return nil
        }
        
        self.init(id: id, name: name)
    }
    
}
