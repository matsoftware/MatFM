//
//  MULSearchDetailViewControllerTests.swift
//  MatFM
//
//  Created by Mattia Campolese on 26/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import XCTest
@testable import MatFM

class MULSearchDetailViewControllerTests: XCTestCase {
    
    var searchDetailViewController: MULSearchDetailViewController!
    
    override func setUp() {
        super.setUp()
        searchDetailViewController = MULSearchTableViewControllerFactory(router: MULStubSearchTableRouter()).makeDetailViewController(track: exampleTracks.first!)
        searchDetailViewController.loadView()
    }
    
    override func tearDown() {
        searchDetailViewController = nil
        super.tearDown()
    }
    
    func test_viewDidLoad_shouldSetPropertiesFromPresenter() {
        
        searchDetailViewController.viewDidLoad()
        
        XCTAssertEqual(searchDetailViewController.lblTitle.text, "The Killers")
        XCTAssertEqual(searchDetailViewController.lblSubtitle.text, "Believe Me Natalie")

    }
    
}
