//
//  Date.swift
//  TheMovieDBCore
//
//  Created by Santex on 11/25/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import Foundation

extension Date {
    
    static func from(movieDBFormat string: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        
        return dateFormatter.date(from: string)
    }
    
    public func toCustomizedString() -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyy"
        
        return dateFormatter.string(from: self)
    }
}
