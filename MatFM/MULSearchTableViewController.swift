//
//  MULSearchTableViewController.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import UIKit

/// The main view controller used to search for tracks. It's a passive component that
/// passes the events to the presenter that will update the view ehen needed.
final class MULSearchTableViewController: UITableViewController {
    
    var presenter: MULSearchTablePresenterProtocol!
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath)
        
        presenter.elementAtIndexPath(indexPath: indexPath) { (title, subtitle, thumbNail) in
            cell.textLabel?.text = title
            cell.detailTextLabel?.text = subtitle
            cell.imageView?.image = thumbNail
        }
        
        return cell
        
    }
    
}

//MARK: MULSearchTableViewProtocol

extension MULSearchTableViewController: MULSearchTableViewProtocol {
    
    func refreshList() {
        
    }

    func showHud(style: MULSearchTableViewHudStyle) {
        
    }
    
}

//MARK: UISearchBarDelegate

extension MULSearchTableViewController: UISearchBarDelegate {

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
    
    
}
