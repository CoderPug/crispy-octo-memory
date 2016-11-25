//
//  MovieDetailViewControllerExtended.swift
//  TheMovieDB
//
//  Created by Santex on 11/25/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import UIKit

extension MovieDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = sections[indexPath.row]
        
        guard let movie = movie else {
            
            return emptyCell
        }
        
        if section == .poster {
            
            guard let imageCell = tableView.dequeueReusableCell(withIdentifier:
                ImageTableViewCellConstants.cellIdentifier) as? ImageTableViewCell else {
                    
                    return emptyCell
            }
            
            imageCell.load(url: movie.imageURL)
            return imageCell
            
        } else {
            
            guard let informationCell = tableView.dequeueReusableCell(withIdentifier:
                InformationTableViewCellConstants.cellIdentifier) as? InformationTableViewCell else {
                    
                    return emptyCell
            }
            
            return informationCell.cell(for: section, movie: movie)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sections.count
    }
    
}
