//
//  MovieListInterfaceController.swif
//  TheMovieDBWatchOS Extension
//
//  Created by Santex on 11/27/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import WatchKit
import Foundation
import TheMovieDBCore

class MovieListInterfaceController: WKInterfaceController {

    @IBOutlet var tableView: WKInterfaceTable!
    var movies: [Movie] = []
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setTitle(NSLocalizedString("MOVIELISTVC_TITLE",
                                   comment: "MOVIELISTVC_TITLE"))
        
        GlobalManager.sharedInstance.connectionManager.requestDiscoverMovies(page: 1) { [weak self] result in
            
            switch result {
                
            case let .Failure(error):
                
                dump(error)
                break
                
            case let .Success(moviePage):
                
                guard let movies = moviePage.movies else {
                    return
                }
                
                self?.movies = movies
                self?.tableView.setNumberOfRows(movies.count,
                                                withRowType: MovieTableRowControllerConstants.identifier)
                
                for index in 0...movies.count - 1 {
                    
                    guard let movieRow = self?.tableView.rowController(at: index) as? MovieTableRowController else {
                        
                        return
                    }
                    
                    movieRow.customize()
                    movieRow.movie = movies[index]
                }
                
                break
            }
        }
    }
    
    override func willActivate() {
        
        super.willActivate()
    }
    
    override func didDeactivate() {
        
        super.didDeactivate()
    }

    //  MARK: -
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        
        let movie = movies[rowIndex]
        presentController(withName: MovieDetailInterfaceControllerConstants.name, context: movie)
    }
}
