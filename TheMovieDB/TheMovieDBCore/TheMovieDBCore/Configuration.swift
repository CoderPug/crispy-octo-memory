//
//  Configuration.swift
//  TheMovieDBCore
//
//  Created by Santex on 11/25/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import Foundation

public protocol APIData {
    
    var serverURL: String { get }
    var APIToken: String { get }
    var language: String? { get set }
    var imagesBaseURL: String? { get set }
    var posterSizes: Array<AnyObject>? { get set }
}

public struct Configuration: APIData {
    
    public var APIToken: String
    public var serverURL: String
    public var language: String?
    public var imagesBaseURL: String?
    public var posterSizes: Array<AnyObject>?
    
    public init(APIToken: String, serverURL: String) {
        
        self.APIToken = APIToken
        self.serverURL = serverURL
        self.language = nil
        self.imagesBaseURL = nil
        self.posterSizes = nil
    }
}

public class AppManager {
    
    public var configuration: Configuration?
    
    public static let sharedInstance: AppManager = AppManager()
    
    init() {
        
        self.configuration = nil
    }
}

extension AppManager {
    
    public func performRequestConfiguration() {
        
        var cm = ConnectionManager()
        cm.configuration = self.configuration
        
        cm.requestConfiguration() { [weak self] result in
            
            switch result {
                
            case let .Failure(error):
                
                dump(error)
                break
                
            case let .Success(configuration):
                
                self?.configuration?.imagesBaseURL = configuration.0
                self?.configuration?.posterSizes = configuration.1
                break
            }
        }
    }
}
