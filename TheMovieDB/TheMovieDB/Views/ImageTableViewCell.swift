//
//  ImageTableViewCell.swift
//  TheMovieDB
//
//  Created by Santex on 11/25/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import UIKit
import TheMovieDBCore

struct ImageTableViewCellConstants {
    
    static let nibName = "ImageTableViewCell"
    static let cellIdentifier = "ImageTableViewCell"
}

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        custommize()
    }
    
    func custommize() {
        
    }
    
    func load(url: String) {
        
        guard let configuration = AppManager.sharedInstance.configuration,
            let imagesBaseURL = configuration.imagesBaseURL else {
                
                return
        }
        
        let imageURL = imagesBaseURL + "w500" + url
        
        let task = URLSession.shared.dataTask(with: NSURL(string: imageURL)! as URL,
                                              completionHandler: { (data, response, error) -> Void in
                                                
                                                guard error == nil, let data = data else {
                                                    
                                                    if error != nil {
                                                        dump(error)
                                                    }
                                                    return
                                                }
                                                
                                                DispatchQueue.main.async(execute: { [weak self] () -> Void in
                                                    
                                                    self?.myImageView.image = UIImage(data: data)
                                                })
        })
        
        task.resume()
    }

}
