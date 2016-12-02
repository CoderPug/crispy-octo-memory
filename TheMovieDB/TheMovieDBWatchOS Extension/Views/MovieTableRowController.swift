//
//  MovieTableRowController.swift
//  TheMovieDB
//
//  Created by Santex on 11/27/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import WatchKit
import TheMovieDBCore

struct MovieTableRowControllerConstants {
    
    static let identifier = "MovieTableRow"
}

class MovieTableRowController: NSObject {

    @IBOutlet var labelTitle: WKInterfaceLabel!
    @IBOutlet var labelSubtitleA: WKInterfaceLabel!
    @IBOutlet var labelSubtitleB: WKInterfaceLabel!
    
    var movie: Movie? {
        
        didSet {
            
            guard let movie = movie else {
                
                return
            }
            
            labelTitle.setText(movie.title)
            labelSubtitleA.setText(movie.stringReleaseDate())
            let oneGenreArray: [Any?] = [movie.genres?.first]
            labelSubtitleB.setText(GlobalManager.sharedInstance.stringGenres(for: oneGenreArray as? Array<Int>) ?? "")
        }
    }
    
    func customize() {
        
        labelTitle.setTextColor(Appearance.Colors.first)
    }
    
}
