//
//  MULSearchTableViewController.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import UIKit
import PKHUD
import SDWebImage

/// The main view controller used to search for tracks. It's a passive component that
/// passes the events to the presenter that will update the view ehen needed.
final class MULSearchTableViewController: UITableViewController {
    
    var presenter: MULSearchTablePresenterProtocol!
    var imageRequester: NETImageRequesting!
    
    let defaultRowHeight = 60
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath)
        
        let (title, subtitle, thumbnail) = (presenter.elementAtIndexPath(indexPath: indexPath)) ?? ("","","")
        
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = subtitle
        
        cell.imageView?.sd_setImage(with: URL(string: thumbnail),
                                    placeholderImage: UIImage(named: "default-placeholder"))
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(defaultRowHeight)
    }
    
}

//MARK: MULSearchTableViewProtocol

extension MULSearchTableViewController: MULSearchTableViewProtocol {
    
    func refreshList() {
        tableView.reloadData()
    }

    func showHud(style: MULSearchTableViewHudStyle) {
        
        HUD.hide()

        switch style {
        case .error:
            HUD.flash(.error)
        case .progress:
            HUD.show(.progress)
        case .success:
            HUD.flash(.success, delay: 1.0)
        }
    }
    
}

//MARK: UISearchBarDelegate

extension MULSearchTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        presenter.searchRequested(searchTerm: searchBar.text ?? "")
    }
    
}
