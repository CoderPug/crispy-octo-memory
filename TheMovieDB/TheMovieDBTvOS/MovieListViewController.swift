//
//  MovieListViewController.swift
//  TheMovieDBTvOS
//
//  Created by Santex on 12/1/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import UIKit
import TheMovieDBCore

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [Movie] = []
    var page: Int  = 1
    var totalPagesOnServer: Int?
    var requestInProcess: Bool = false
    
    let numberOfElementsBeforeReloading = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib.init(nibName: "MovieCollectionViewCell",
                                           bundle: Bundle.main),
                                forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        performRequestDiscoverMovies(page: page)
    }
    
    //  MARK: Requests
    
    func performRequestDiscoverMovies(page: Int) {
        
        DispatchQueue.global().async { [weak self] in
            
            GlobalManager.sharedInstance.connectionManager.requestDiscoverMovies(page: page) { [weak self] result in
                
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
                    
                    let indexes = getIndexPaths(from: currentMovies.count, upper: upcomingMovies.count)
                    
                    DispatchQueue.main.async(execute: { [weak self] () -> Void in
                        
                        self?.requestInProcess = false
                        self?.collectionView.insertItems(at: indexes)
                    })
                    break
                }
            }
        }
    }
    
}

//  MARK: - UICollectionViewDataSource

extension MovieListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCellConstants.cellIdentifier,
                                                            for: indexPath) as? MovieCollectionViewCell else {
                                                                return UICollectionViewCell()
        }
        
        let movie = movies[indexPath.row]
        
        cell.load(movie)
        
        if requestInProcess == false && indexPath.row >= (movies.count - numberOfElementsBeforeReloading) {
            
            if let totalPagesOnServer = totalPagesOnServer {
                
                if page < totalPagesOnServer {
                    
                    requestInProcess = true
                    performRequestDiscoverMovies(page: page + 1)
                }
            }
        }
        
        return cell
    }
    
}
