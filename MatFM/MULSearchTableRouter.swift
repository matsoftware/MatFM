//
//  MULSearchTableRouter.swift
//  MatFM
//
//  Created by Mattia Campolese on 26/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import UIKit

protocol MULSearchTableRouterProtocol: class {
    
    func presentSearchTableViewController(window: UIWindow)
    
    func presentDetailSearchViewController(track: MUSTrack)
    
}

/// Basic implementation of the routing function for the MusicLibrary module.
/// It's responsible of presenting the detail ViewController.
final class MULSearchTableRouter: MULSearchTableRouterProtocol {
    
    var viewControllerFactory: MULSearchTableViewControllerFactory!

    func presentSearchTableViewController(window: UIWindow) {
        window.rootViewController = searchTableViewController
    }
    
    func presentDetailSearchViewController(track: MUSTrack) {

        let detailViewController = viewControllerFactory.makeDetailViewController(track: track)
    
        searchTableViewController.pushViewController(detailViewController, animated: true)
    
    }
    
    private lazy var searchTableViewController: UINavigationController = {
        return self.viewControllerFactory.makeSearchTableViewController()
    }()
    
}
