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
    
    public var connectionManager: ConnectionManager
    
    public var data: DataManager
    
    init() {
        
        connectionManager = ConnectionManager()
        data = DataManager()
    }
    
    func setConfiguration(_ configuration: Configuration) {
        
        connectionManager.configuration = configuration
    }
    
    func configuration() -> Configuration? {
        
        return connectionManager.configuration as? Configuration
    }
    
}

extension GlobalManager {
    
    public func genres(for array: [Int]?) -> [String]? {
        
        guard let array = array, let movieGenres = data.movieGenres else {

            return nil
        }
        
        var results: [String] = []
        
        for item in array {
            
            if let genre = movieGenres.filter({ $0.id == item }).first {
                
                results.append(genre.name)
            } else {
                
                results.append("\(item)")
            }
        }
        
        return results
    }
    
    public func stringGenres(for array: [Int]?) -> String? {
        
        if let arrayGenres = genres(for: array) {
            
            return arrayGenres.map({ "\($0)" }).joined(separator: ", ")
        }
        
        return nil
    }
    
}

extension GlobalManager {
    
    public func performRequestConfiguration() {
        
        connectionManager.requestConfiguration() { [weak self] result in
            
            switch result {
                
            case let .Failure(error):
                
                dump(error)
                break
                
            case let .Success(configuration):
                
                self?.connectionManager.configuration?.imagesBaseURL = configuration.0
                self?.connectionManager.configuration?.posterSizes = configuration.1
                break
            }
        }
    }
    
    public func performRequestMovieGenres() {
        
        connectionManager.requestGenre() { [weak self] result in
         
            switch result {
                
            case let .Failure(error):
                
                dump(error)
                break
                
            case let .Success(movieGenres):
                
                self?.data.movieGenres = movieGenres
                break
            }
        }
    }
}
