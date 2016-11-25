//
//  MovieDetailViewController.swift
//  TheMovieDB
//
//  Created by Santex on 11/25/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import UIKit
import TheMovieDBCore

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let movie: Movie? = nil
    
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
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
    }
    
}

extension MovieDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InformationTableViewCellConstants.cellIdentifier)
        as? InformationTableViewCell else {
            
            return UITableViewCell()
        }
        
        cell.load(title: "Ejemplo", detail: "de un texto cualquiera")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }

}
