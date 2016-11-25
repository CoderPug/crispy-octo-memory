//
//  MovieDetailViewController.swift
//  TheMovieDB
//
//  Created by Santex on 11/25/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import UIKit
import TheMovieDBCore

enum MovieDetailSections {
    
    case poster
    case name
    case genre
    case overview
    case releaseDate
}

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var sections: [MovieDetailSections] = [.poster, .name, .releaseDate, .genre, .overview]
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    //  MARK: Private
    
    func configureView() {
        
        title = NSLocalizedString("MOVIEDETAILVC_TITLE", comment: "MOVIELISTVC_TITLE")
        
        tableView.register(UINib.init(nibName: InformationTableViewCellConstants.nibName,
                                      bundle: Bundle.main),
                           forCellReuseIdentifier: InformationTableViewCellConstants.cellIdentifier)
        tableView.register(UINib.init(nibName: ImageTableViewCellConstants.nibName,
                                      bundle: Bundle.main),
                           forCellReuseIdentifier: ImageTableViewCellConstants.cellIdentifier)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = InformationTableViewCellConstants.estimatedHeight
    }
    
}

extension MovieDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = sections[indexPath.row]
        
        guard let movie = movie else {
            
            return UITableViewCell()
        }
        
        if section == .poster {
            
            guard let imageCell = tableView.dequeueReusableCell(withIdentifier:
                ImageTableViewCellConstants.cellIdentifier) as? ImageTableViewCell else {
                    
                    return UITableViewCell()
            }
            
            imageCell.load(url: movie.imageURL)
            return imageCell
            
        } else {
            
            guard let informationCell = tableView.dequeueReusableCell(withIdentifier:
                InformationTableViewCellConstants.cellIdentifier) as? InformationTableViewCell else {
            
                    return UITableViewCell()
            }
            
            return informationCell.cell(for: section, movie: movie)
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sections.count
    }

}
