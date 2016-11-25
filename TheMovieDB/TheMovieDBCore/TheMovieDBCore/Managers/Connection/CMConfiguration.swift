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

struct CMConfigurationJSONKeys {
    
    static let images = "images"
    static let secureBaseURL = "secure_base_url"
    static let posterSizes = "poster_sizes"
}

extension ConnectionManager {
    
    public typealias CMConfigurationType = (String?, Array<AnyObject>?)
    
    public func requestConfiguration(_ handler: @escaping (Result<CMConfigurationType>) -> Swift.Void ) {
        
        request(URI: CMConfigurationConstants.URIConfiguration) { data, response, error in
            
            guard let data = data, error == nil else {

                handler(.Failure(error ?? TheMovieDBError.unkwnon))
                return
            }
            
            guard let dictionary = data.toJSON(),
                let images = dictionary[CMConfigurationJSONKeys.images] as? [String: AnyObject],
                let baseURL = images[CMConfigurationJSONKeys.secureBaseURL] as? String,
                let posterSizes = images[CMConfigurationJSONKeys.posterSizes] as? [AnyObject] else {
                    
                    handler(.Failure(TheMovieDBError.missingKey))
                    return
            }
            
            handler(.Success((baseURL, posterSizes)))
        }
    }
    
}
