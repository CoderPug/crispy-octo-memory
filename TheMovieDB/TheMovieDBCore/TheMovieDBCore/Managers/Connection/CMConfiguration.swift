//
//  CMConfiguration.swift
//  TheMovieDBCore
//
//  Created by Santex on 11/25/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import Foundation

struct CMConfigurationConstants {
    
    static let URIConfiguration = "configuration"
}

extension ConnectionManager {
    
    public typealias CMConfigurationType = (String?, Array<AnyObject>?)
    
    public func requestConfiguration(_ handler: @escaping (Result<CMConfigurationType>) -> Swift.Void ) {
        
        request(URI: CMConfigurationConstants.URIConfiguration) { data, response, error in
            
            guard let data = data, error == nil else {

                return
            }
            
            guard let dictionary = data.toJSON(),
                let images = dictionary["images"] as? [String: AnyObject],
                let baseURL = images["secure_base_url"] as? String,
                let posterSizes = images["poster_sizes"] as? [AnyObject] else {
                    
                    return
            }
            
            handler(.Success((baseURL, posterSizes)))
        }
    }
    
}
