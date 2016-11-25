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
