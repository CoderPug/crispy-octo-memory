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
    var releaseDate: Date
    
    init(id: Int, title: String, description: String, imageURL: String, releaseDate: Date) {
        
        self.id = id
        self.title = title
        self.description = description
        self.imageURL = imageURL
        self.releaseDate = releaseDate
    }
    
}

struct MovieJSONKeys {
    
    static let id = "id"
    static let title = "title"
    static let description = "overview"
    static let imageURL = "poster_path"
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
        
        self.init(id: id, title: title, description: description, imageURL: imageURL, releaseDate: Date())
    }
}
