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
    var page: Int  = 1
    var totalPagesOnServer: Int?
    var requestInProcess: Bool = false
    
    let numberOfElementsBeforeReloading = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
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
    
    //  MARK: Requests
    
    func performRequestDiscoverMovies(page: Int) {
        
        DispatchQueue.global().async { [weak self] in
            
            self?.requestInProcess = true
            
            GlobalManager.sharedInstance.connectionManager.requestDiscoverMovies(page: page) { [weak self] result in
                
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
                        
                        let indexes = getIndexPaths(from: currentMovies.count, upper: upcomingMovies.count)
                        self?.collectionView.insertItems(at: indexes)
                    })
                    break
                }
            }
        }
    }
    
}
