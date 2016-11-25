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
