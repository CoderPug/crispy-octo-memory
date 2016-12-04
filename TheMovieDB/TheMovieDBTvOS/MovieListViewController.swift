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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performRequestDiscoverMovies(page: 1)
        
        
        collectionView.register(UINib.init(nibName: "MovieCollectionViewCell",
                                           bundle: Bundle.main),
                                           forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
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
                    
                    guard let currentMovies = self?.movies,
                        let upcomingMovies = moviePage.movies else {
                            
                            return
                    }
                    
                    self?.movies = upcomingMovies
                    
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

//  MARK: - UICollectionViewDataSource

extension MovieListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell
        let movie = movies[indexPath.row]
        
        cell?.labelTitle.text = movie.title
        
        guard let configuration = GlobalManager.sharedInstance.configuration(),
            let imagesBaseURL = configuration.imagesBaseURL else {
                
                return cell ?? UICollectionViewCell()
        }
        
        let imageURL = imagesBaseURL + "w500" + movie.imageURL
        
        var task: URLSessionDataTask?
        
        task = URLSession.shared.dataTask(with: NSURL(string: imageURL)! as URL,
                                          completionHandler: { (data, response, error) -> Void in
                                            
                                            
                                            guard error == nil, let data = data else {
                                                
                                                if error != nil {
                                                    dump(error)
                                                }
                                                return
                                            }
                                            
                                            DispatchQueue.main.async(execute: { () -> Void in
                                                
                                                cell?.imageViewPoster.image = UIImage(data: data)
                                                
                                            })
        })
        
        task?.resume()
        
        return cell ?? UICollectionViewCell()
    }
    
}
