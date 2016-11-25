//
//  Data.swift
//  TheMovieDBCore
//
//  Created by Santex on 11/25/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

extension Data {
    
    func toJSON() -> [String: AnyObject]? {
        
        var json: Any?
        
        do {
            
            json = try JSONSerialization.jsonObject(with: self, options: [])
            
        } catch {
            
            return nil
        }
        
        return json as? [String: AnyObject]
    }

}
