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
    var dispatcher: UTLMainQueueDispatching = UTLMainQueueDispatcher()

    let defaultRowHeight = 60
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath)
        
        let (title, subtitle, thumbnail) = (presenter.elementAtIndex(index: indexPath.row)) ?? ("","","")
        
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = subtitle
        
        cell.imageView?.image = UIImage(named: "default-placeholder")
        
        presenter.imageDataForThumbnailUrl(url: thumbnail) { [unowned self] (data) in
            guard let data = data else { return }
            self.dispatcher.async {
                if let cell = tableView.cellForRow(at: indexPath) {
                    cell.imageView?.image = UIImage(data: data)
                }
            }
        }
 
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(defaultRowHeight)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.elementSelected(index: indexPath.row)
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
            HUD.flash(.success)
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
