//
//  MovieDetailInterfaceController.swift
//  TheMovieDB
//
//  Created by Santex on 11/27/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import WatchKit
import Foundation
import TheMovieDBCore

struct MovieDetailInterfaceControllerConstants {
    
    static let name = "MovieDetailInterfaceController"
}

class MovieDetailInterfaceController: WKInterfaceController {

    @IBOutlet var labelTitle: WKInterfaceLabel!
    @IBOutlet var labelSectionATitle: WKInterfaceLabel!
    @IBOutlet var labelSectionAContent: WKInterfaceLabel!
    @IBOutlet var labelSectionBTitle: WKInterfaceLabel!
    @IBOutlet var labelSectionBContent: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        customize()
        
        guard let movie = context as? Movie else {
            
            return
        }
        
        loadContent(movie: movie)
    }
    
    override func willActivate() {
        
        super.willActivate()
    }
    
    override func didDeactivate() {
        
        super.didDeactivate()
    }
    
    //  MARK: -
    
    func customize() {
        
        labelTitle.setTextColor(Appearance.Colors.first)
    }
    
    func loadContent(movie: Movie?) {
        
        labelTitle.setText(movie?.title ?? "")
        labelSectionATitle.setText(NSLocalizedString("MOVIEDETAILVC_GENRE",
                                                     comment: "MOVIEDETAILVC_GENRE"))
        labelSectionAContent.setText(GlobalManager.sharedInstance.stringGenres(for:
            movie?.genres as? Array<Int>) ?? "")
        labelSectionBTitle.setText(NSLocalizedString("MOVIEDETAILVC_OVERVIEW",
                                                     comment: "MOVIEDETAILVC_OVERVIEW"))
        labelSectionBContent.setText(movie?.description ?? "")
    }

}
