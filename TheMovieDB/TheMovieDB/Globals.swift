//
//  Globals.swift
//  TheMovieDB
//
//  Created by Santex on 11/25/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import Foundation

func getLanguage() -> String? {
    
    return NSLocale.current.languageCode
}

func getIndexPaths(from start: Int, upper: Int) -> [IndexPath] {
    
    var result = [IndexPath]()
    
    for i in start ... start + upper - 1  {
        
        result.append(IndexPath(row: i, section: 0))
    }
    
    return result
}
