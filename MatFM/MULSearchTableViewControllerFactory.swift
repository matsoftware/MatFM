//
//  MULSearchTableViewControllerFactory.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import UIKit

final class MULSearchTableViewControllerFactory {
    
    weak var router: MULSearchTableRouterProtocol?
    
    init(router: MULSearchTableRouterProtocol?) {
        self.router = router
    }
    
    func makeSearchTableViewController() -> UINavigationController {
        
        let presenter = MULSearchTablePresenter(musicQueryService: MUSLastFMTracksQueryService(), imageService: NETImageRequester(), router: router!)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MULSearchTableViewController") as! MULSearchTableViewController
        presenter.view = viewController
        viewController.presenter = presenter
        
        return UINavigationController(rootViewController: viewController)
        
    }
    
    func makeDetailViewController(track: MUSTrack) -> MULSearchDetailViewController {
        
        let presenter = MULSearchDetailPresenter(selectedTrack: track)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MULSearchDetailViewController") as! MULSearchDetailViewController
        viewController.presenter = presenter
        
        return viewController
        
    }
    
    private lazy var storyboard: UIStoryboard! = {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }()
    
}
