//
//  MULSearchTableViewControllerFactory.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import UIKit

final class MULSearchTableViewControllerFactory {
    
    func makeSearchTableViewController() -> UIViewController {
        
        let presenter = MULSearchTablePresenter(musicQueryService: MUSLastFMTracksQueryService())
        let viewController = storyboard.instantiateViewController(withIdentifier: "MULSearchTableViewController") as! MULSearchTableViewController
        presenter.view = viewController
        viewController.presenter = presenter
        
        return UINavigationController(rootViewController: viewController)
        
    }
    
    private lazy var storyboard: UIStoryboard! = {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }()
    
}
