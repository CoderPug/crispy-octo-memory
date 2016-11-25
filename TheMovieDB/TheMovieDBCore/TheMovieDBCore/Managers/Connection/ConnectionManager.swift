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

public struct ConnectionManager {
    
    public var configuration: APIData?
    
    public init() {
        
    }
    
    func request(URI: String, handler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        
        guard let configuration = configuration else {
            
            return
        }
        
        let parameters = ["api_key": configuration.APIToken, "language": configuration.language].httpParameters()
        
        let url = URL(string:"\(configuration.serverURL)\(URI)?\(parameters)")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: handler)
        
        task.resume()
    }
    
}
