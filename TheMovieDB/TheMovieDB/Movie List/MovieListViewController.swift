//
//  MovieListViewController.swift
//  TheMovieDB
//
//  Created by Santex on 11/25/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import UIKit
import TheMovieDBCore

struct MovieListSegueIdentifiers {
    
    static let toDetailViewController = "showDetail"
}

class MovieListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [Movie] = []
    var cm = ConnectionManager()
    var page: Int  = 1
    var totalPagesOnServer: Int?
    var requestInProcess: Bool = false
    
    let numberOfElementsBeforeReloading = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureCurrentEnvironment()
        
        performRequestConfiguration()
        performRequestDiscoverMovies(page: page)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard segue.identifier == MovieListSegueIdentifiers.toDetailViewController,
            let destination = segue.destination as? MovieDetailViewController,
            let movie = sender as? Movie else {
            
                return
        }
        
        destination.movie = movie
    }
    
    //  MARK: Private
    
    func configureView() {
        
        view.backgroundColor = Appearance.Colors.empty
        
        title = NSLocalizedString("MOVIELISTVC_TITLE", comment: "MOVIELISTVC_TITLE")
        
        collectionView.register(UINib.init(nibName: MovieCollectionViewCellConstants.nibName,
                                           bundle: Bundle.main),
                                forCellWithReuseIdentifier: MovieCollectionViewCellConstants.cellIdentifier)
    }
    
    func configureCurrentEnvironment() {
        
        cm.configuration = AppManager.sharedInstance.configuration
    }
    
    //  MARK: Requests
    
    func performRequestConfiguration() {
        
        cm.requestConfiguration() { result in
            
            switch result {
                
            case let .Failure(error):
                
                dump(error)
                break
                
            case let .Success(configuration):
                
                AppManager.sharedInstance.configuration?.imagesBaseURL = configuration.0
                AppManager.sharedInstance.configuration?.posterSizes = configuration.1
                break
            }
        }
    }
    
    func performRequestDiscoverMovies(page: Int) {
        
        DispatchQueue.global().async { [weak self] in
            
            self?.requestInProcess = true
            
            self?.cm.requestDiscoverMovies(page: page) { [weak self] result in
                
                self?.requestInProcess = false
                
                switch result {
                    
                case let .Failure(error):
                    
                    dump(error)
                    break
                    
                case let .Success(moviePage):
                    
                    self?.page = moviePage.page
                    self?.totalPagesOnServer = moviePage.totalPages
                    
                    guard let currentMovies = self?.movies,
                        let upcomingMovies = moviePage.movies else {
                            
                            return
                    }
                    
                    self?.movies = currentMovies + upcomingMovies
                    
                    DispatchQueue.main.async(execute: { [weak self] () -> Void in
                        
                        self?.collectionView.performBatchUpdates( {
                        
                            let indexes = getIndexPaths(from: currentMovies.count, upper: upcomingMovies.count)
                            self?.collectionView.insertItems(at: indexes)
                            
                        }, completion: { finished in
                            
                        })
                    })
                    break
                }
            }
        }
    }
    
}
