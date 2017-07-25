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
class MULSearchTableViewController: UITableViewController {
    
    var presenter: MULSearchTablePresenterProtocol?
    
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
