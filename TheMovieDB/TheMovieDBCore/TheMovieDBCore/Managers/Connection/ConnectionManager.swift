//
//  ConnectionManager.swift
//  TheMovieDBCore
//
//  Created by Santex on 11/25/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import Foundation

public enum Result<T> {
    
    case Failure(Error)
    case Success(T)
}

struct URLParametersKeys {
    
    static let APIKey = "api_key"
    static let language = "language"
}

func +<Key, Value> (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
    var result = lhs
    rhs.forEach{ result[$0] = $1 }
    return result
}

public struct ConnectionManager {
    
    public var configuration: APIData?
    
    public init() {
        
    }
    
    func request(URI: String,
                 parameters: [String: String],
                 handler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
    
        guard let configuration = configuration else {
            
            handler(nil, nil, TheMovieDBError.missingConfigurationData)
            return
        }
        
        let baseParameters = [URLParametersKeys.APIKey: configuration.APIToken,
                              URLParametersKeys.language: configuration.language ?? ""]
        
        let composedParameters = baseParameters + parameters

        let httpParameters = composedParameters.httpParameters()
        
        let url = URL(string:"\(configuration.serverURL)\(URI)?\(httpParameters)")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: handler)
        
        task.resume()
    }
    
    func request(URI: String, handler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        
        request(URI: URI, parameters: [:], handler: handler)
    }
    
}
