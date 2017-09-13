//
//  MULSearchTableViewControllerTests.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import XCTest
@testable import MatFM

class MULSearchTableViewControllerTests: XCTestCase {
    
    var stubPresenter: MULStubSearchTablePresenter!
    var searchTableVieWController: MULSearchTableViewController!
    
    override func setUp() {
        super.setUp()
        stubPresenter = MULStubSearchTablePresenter()
        searchTableVieWController = MULSearchTableViewController()
        searchTableVieWController.presenter = stubPresenter
        searchTableVieWController.dispatcher = UTLStubMainQueueDispatcher()
    }
    
    override func tearDown() {
        stubPresenter = nil
        searchTableVieWController = nil
        super.tearDown()
    }
    
    func test_numberOfSections_shouldReturnThePresenterNumberOfSection() {
        
        let numberOfSections = searchTableVieWController.numberOfSections(in: UITableView())
        
        XCTAssertEqual(numberOfSections, 10)
        
    }
    
    func test_numberOfRows_shouldReturnThePresenterNumberOfRows() {
        
        let numberOfRows = searchTableVieWController.tableView(UITableView(), numberOfRowsInSection: 0)
        
        XCTAssertEqual(numberOfRows, 20)
        
    }
    
    func test_cellForRowAtIndexPath_shouldReturnThePresenterNumberOfRows() {
        
        let cell = searchTableVieWController.tableView(MockUITableView(), cellForRowAt: IndexPath(row: 3, section: 4))
        
        XCTAssertEqual(stubPresenter.elementIndex,3)
        XCTAssertEqual(cell.textLabel?.text, "mockTitle")
        XCTAssertEqual(cell.detailTextLabel?.text, "mockSubtitle")
        
    }
    
    
    func test_cellForRowAtIndexPath_requestTheImageThumbnailFromPresenter() {
        
        stubPresenter.expectedImageData = imageData
        
        _ = searchTableVieWController.tableView(MockUITableView(), cellForRowAt: IndexPath(row: 3, section: 4))
        
        XCTAssertEqual(stubPresenter.imageDataCalledUrl,"mockImageURL")
        
    }
    
    func test_didSelectRow_shouldCallPresenterElementSelected() {
        
        let indexPath = IndexPath(row: 3, section: 0)
        searchTableVieWController.tableView(MockUITableView(), didSelectRowAt: indexPath)
        
        XCTAssertEqual(stubPresenter.elementSelectedIndex, 3)
        
    }
    
    func test_tableViewHeightForRowAtIndexPath_shouldReturnExpectedValue() {
        
        XCTAssertEqual(searchTableVieWController.tableView(UITableView(), heightForRowAt: IndexPath(item: 1, section: 0)), 60)
                
    }
    
    func test_searchBarSearchButtonClicked_shouldCallPresenterSearchRequestedMethodWithTerm() {
        
        let searchBar = UISearchBar()
        searchBar.text = "Test"
        
        searchTableVieWController.searchBarSearchButtonClicked(searchBar)
        
        XCTAssertEqual(stubPresenter.searchRequestedTerm, "Test")
        
    }
    
}

class MockUITableView: UITableView {
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: .subtitle, reuseIdentifier: "")
    }
    
}
