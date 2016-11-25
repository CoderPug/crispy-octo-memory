//
//  Dictionary.swift
//  TheMovieDBCore
//
//  Created by Santex on 11/25/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

extension Dictionary {
    
    mutating func merge(with dictionary: Dictionary) {
        
        dictionary.forEach { updateValue($1, forKey: $0) }
    }
    
    func merged(with dictionary: Dictionary) -> Dictionary {
        
        var dictionary = self
        dictionary.merge(with: dictionary)
        return dictionary
    }
    
    func httpParameters() -> String {
        
        let result = self.map { (key, value) -> String in
            
            guard let convertedKey = (key as? String)?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                let convertedValue = (value as? String)?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                    
                    return ""
            }
            
            return "\(convertedKey)=\(convertedValue)"
        }
        
        return result.joined(separator: "&")
    }
    
}
