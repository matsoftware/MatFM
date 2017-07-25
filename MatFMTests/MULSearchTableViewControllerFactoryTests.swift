//
//  MULSearchTableViewControllerFactoryTests.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import XCTest
@testable import MatFM

class MULSearchTableViewControllerFactoryTests: XCTestCase {
    
    func test_makeSearchTableViewController_shouldReturnAnInstanceOfUINavigationController() {
        
        let factory = MULSearchTableViewControllerFactory()
        let viewController = factory.makeSearchTableViewController()
        
        XCTAssertTrue(viewController is UINavigationController)
        
    }
    
}
