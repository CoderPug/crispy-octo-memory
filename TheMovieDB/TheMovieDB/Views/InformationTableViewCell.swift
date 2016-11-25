//
//  InformationTableViewCell.swift
//  TheMovieDB
//
//  Created by Santex on 11/25/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import UIKit

struct InformationTableViewCellConstants {
    
    static let nibName = "InformationTableViewCell"
    static let cellIdentifier = "InformationTableViewCell"
    static let estimatedHeight: CGFloat = 60
}

class InformationTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        custommize()
    }
    
    func custommize() {
        
        self.labelTitle.font = Appearance.Fonts.h4
        self.labelTitle.textColor = Appearance.Colors.third
        self.labelDetail.font = Appearance.Fonts.text
        self.labelDetail.textColor = Appearance.Colors.third
    }

    func load(title: String, detail: String) {
        
        labelTitle.text = title
        labelDetail.text = detail
    }
    
}

import TheMovieDBCore

extension InformationTableViewCell {
    
    public func cell(for section: MovieDetailSections, movie: Movie) -> Self {
        
        var temporalTitle: String?
        var temporalDetail: String?
        
        switch section {
        case .name:
            temporalTitle = NSLocalizedString("MOVIEDETAILVC_MOVIENAME", comment: "MOVIEDETAILVC_MOVIENAME")
            temporalDetail = movie.title
            break
            
        case .overview:
            temporalTitle = NSLocalizedString("MOVIEDETAILVC_OVERVIEW", comment: "MOVIEDETAILVC_OVERVIEW")
            temporalDetail = movie.description
            break
            
        case .releaseDate:
            temporalTitle = NSLocalizedString("MOVIEDETAILVC_RELEASE_DATE", comment: "MOVIEDETAILVC_RELEASE_DATE")
            temporalDetail = movie.releaseDate?.toCustomizedString() ?? ""
            break
            
        case .genre:
            var genreString: String?
            if let genre = movie.genres as? Array<Int> {
                genreString = genre.map({"\($0)"}).joined(separator: ", ")
            }
            temporalTitle = NSLocalizedString("MOVIEDETAILVC_GENRE", comment: "MOVIEDETAILVC_GENRE")
            temporalDetail = genreString ?? ""
            break
            
        default:
            
            break
        }
        
        guard let title = temporalTitle,
            let detail = temporalDetail else {
            
                return self
        }
        
        load(title: title, detail: detail)
        
        return self
    }
}