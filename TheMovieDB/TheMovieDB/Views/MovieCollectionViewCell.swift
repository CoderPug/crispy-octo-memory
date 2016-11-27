//
//  MovieCollectionViewCell.swift
//  TheMovieDB
//
//  Created by Santex on 11/25/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import UIKit
import TheMovieDBCore

struct MovieCollectionViewCellConstants {
    
    static let nibName = "MovieCollectionViewCell"
    static let cellIdentifier = "MovieCollectionViewCell"
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubtitleA: UILabel!
    @IBOutlet weak var labelSubtitleB: UILabel!
    
    var task: URLSessionDataTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        custommize()
    }
    
    func custommize() {
        
        labelTitle.font = Appearance.Fonts.h3
        labelTitle.textColor = Appearance.Colors.second
        labelSubtitleA.font = Appearance.Fonts.detailText
        labelSubtitleA.textColor = Appearance.Colors.second
        labelSubtitleB.font = Appearance.Fonts.detailText
        labelSubtitleA.textColor = Appearance.Colors.second
    }
    
    override func prepareForReuse() {
        
        labelTitle.text = ""
        labelSubtitleA.text = ""
        labelSubtitleB.text = ""
        imageViewPoster.image = nil
        task?.cancel()
    }
    
    func load(_ movie: Movie) {
        
        labelTitle.text = movie.title
        labelSubtitleA.text = movie.releaseDate?.toCustomizedDate() ?? ""
        if let arrayGenres = GlobalManager.sharedInstance.genres(for: movie.genres as? Array<Int>) {
            labelSubtitleB.text = arrayGenres.map({"\($0)"}).joined(separator: ", ")
        }
        
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
