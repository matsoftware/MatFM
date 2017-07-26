//
//  MULStubSearchTableRouter.swift
//  MatFM
//
//  Created by Mattia Campolese on 26/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import UIKit
@testable import MatFM

class MULStubSearchTableRouter: MULSearchTableRouterProtocol {
    
    private(set) var presentDetailSearchViewControllerCalledWithTrack: MUSTrack?
    
    func presentSearchTableViewController(window: UIWindow) {
        
    }
    
    func presentDetailSearchViewController(track: MUSTrack) {
        presentDetailSearchViewControllerCalledWithTrack = track
    }
    
    
}
