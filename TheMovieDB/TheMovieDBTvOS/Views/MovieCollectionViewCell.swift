//
//  MovieCollectionViewCell.swift
//  TheMovieDB
//
//  Created by Santex on 12/3/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import UIKit
import TheMovieDBCore

struct MovieCollectionViewCellConstants {
    
    static let nibName = "MovieCollectionViewCell"
    static let cellIdentifier = "MovieCollectionViewCell"
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageViewPoster: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    
    @IBOutlet var unfocusedConstraintTopTitle: NSLayoutConstraint!
    var focusedConstraintTopTitle: NSLayoutConstraint!
    
    var task: URLSessionDataTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        focusedConstraintTopTitle = labelTitle.topAnchor.constraint(
            equalTo: imageViewPoster.focusedFrameGuide.bottomAnchor,
            constant: 15.0)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        focusedConstraintTopTitle.isActive = isFocused
        unfocusedConstraintTopTitle.isActive = !isFocused
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        
        setNeedsUpdateConstraints()
        coordinator.addCoordinatedAnimations({
            self.layoutIfNeeded()
        }, completion:
            nil
        )
    }
    
    override func prepareForReuse() {
        
        labelTitle.text = ""
        imageViewPoster.image = nil
        task?.cancel()
    }
    
    //  MARK: -
    
    func load(_ movie: Movie) {
        
        labelTitle.text = movie.title
        
        guard let configuration = GlobalManager.sharedInstance.configuration(),
            let imagesBaseURL = configuration.imagesBaseURL else {
                
                return
        }
        
        let imageURL = imagesBaseURL + "w154" + movie.imageURL
        
        task = URLSession.shared.dataTask(with: NSURL(string: imageURL)! as URL,
                                          completionHandler: { (data, response, error) -> Void in
                                            
                                            
                                            guard error == nil, let data = data else {
                                                
                                                if error != nil {
                                                    dump(error)
                                                }
                                                return
                                            }
                                            
                                            DispatchQueue.main.async(execute: { [weak self] () -> Void in
                                                
                                                self?.imageViewPoster.image = UIImage(data: data)
                                                
                                            })
        })
        
        task?.resume()
    }

}
