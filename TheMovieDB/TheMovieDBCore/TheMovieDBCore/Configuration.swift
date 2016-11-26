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
    
    public init(APIToken: String, serverURL: String, language: String?) {
        
        self.APIToken = APIToken
        self.serverURL = serverURL
        self.language = language
        self.imagesBaseURL = nil
        self.posterSizes = nil
    }
}
