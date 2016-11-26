//
//  GlobalManager.swift
//  TheMovieDB
//
//  Created by Santex on 11/26/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import Foundation
import TheMovieDBCore

public class GlobalManager {
    
    static let sharedInstance: GlobalManager = GlobalManager()
    
    public var data: DataManager
    
    init() {
        
        data = DataManager()
    }
}

extension GlobalManager {
    
    public func genres(for array: Array<Int>?) -> Array<String>? {
        
        guard let array = array, let movieGenres = data.movieGenres else {

            return nil
        }
        
        var results: Array<String> = []
        
        for item in array {
            
            if let genre = movieGenres.filter({$0.id == item}).first {
                
                results.append(genre.name)
            }
        }
        
        return results
    }
    
}
