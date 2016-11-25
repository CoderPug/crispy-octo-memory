//
//  Error.swift
//  TheMovieDBCore
//
//  Created by Santex on 11/25/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import Foundation

enum ChallengeError: Error {
    
    case missingConfigurationData
    case missingKey
    case JSONParseFailed(reason: String)
    case unkwnon
}
