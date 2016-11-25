//
//  MovieListViewControllerExtended.swift
//  TheMovieDB
//
//  Created by Santex on 11/25/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import UIKit

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
                    
                    performRequestDiscoverMovies(page: page + 1)
                }
            }
        }
        
        return cell
    }
    
}

//  MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

struct LayoutConstraints {
    
    static let posterWidth: CGFloat = 160
    static let posterHeight: CGFloat = 250
    static let margin: CGFloat = 10
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let movie = movies[indexPath.row]
        performSegue(withIdentifier: MovieListSegueIdentifiers.toDetailViewController, sender: movie)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: max(self.view.frame.size.width/4, LayoutConstraints.posterWidth),
                      height: max(self.view.frame.size.height/4, LayoutConstraints.posterHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: LayoutConstraints.margin,
                            left: LayoutConstraints.margin,
                            bottom: LayoutConstraints.margin,
                            right: LayoutConstraints.margin)
    }
    
}

