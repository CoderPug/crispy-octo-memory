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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureCurrentEnvironment()
        
        performRequestConfiguration()
        performRequestDiscoverMovies()
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
    
    func performRequestDiscoverMovies() {
        
        cm.requestDiscoverMovies() { [weak self] result in
            
            switch result {
                
            case let .Failure(error):
                
                dump(error)
                break
                
            case let .Success(moviePage):
                
                self?.movies = moviePage.movies ?? []
                
                DispatchQueue.main.async(execute: { [weak self] () -> Void in
                    
                    self?.collectionView.reloadData()
                })
                break
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
        
        return cell
    }
    
}

//  MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let movie = movies[indexPath.row]
        performSegue(withIdentifier: MovieListSegueIdentifiers.toDetailViewController, sender: movie)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: max(self.view.frame.size.width/4, 160),
                      height: max(self.view.frame.size.height/4, 250))
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

}
