//
//  MovieCollectionViewCell.swift
//  TheMovieDB
//
//  Created by Santex on 11/25/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import UIKit
import TheMovieDBCore

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    var configuration: APIData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setConfiguration(_ config: APIData?) {
        
        configuration = config
    }
    
    func load(_ movie: Movie) {
        
        labelTitle.text = movie.title
        
        guard let configuration = configuration,
            let imagesBaseURL = configuration.imagesBaseURL else {
                
                return
        }
        
        let imageURL = imagesBaseURL + "w500" + movie.imageURL
        
        let task = URLSession.shared.dataTask(with: NSURL(string: imageURL)! as URL,
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
        
        task.resume()
    }

}
