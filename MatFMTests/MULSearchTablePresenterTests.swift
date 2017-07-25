//
//  MULSearchTablePresenterTests.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation
import XCTest
@testable import MatFM

class MULSearchTablePresenterTests: XCTestCase {
    
    var stubMusicService: MUSStubTracksQueryService!
    var stubView: MULStubSearchTableView!
    var presenter: MULSearchTablePresenter!
    
    override func setUp() {
        super.setUp()
        stubMusicService = MUSStubTracksQueryService()
        stubView = MULStubSearchTableView()
        presenter = MULSearchTablePresenter(musicQueryService: stubMusicService)
        presenter.view = stubView
    }
    
    override func tearDown() {
        presenter = nil
        stubMusicService = nil
        stubView = nil
        super.tearDown()
    }
    
    func test_searchRequested_shouldCallMusicServiceWithSearchTerm() {
        
        presenter.searchRequested(searchTerm: "Term")
        
        XCTAssertEqual(stubMusicService.requestedTrackName, "Term")
        
    }
    
    func test_searchRequested_shouldCallViewShowProgressHud() {
        
        presenter.searchRequested(searchTerm: "Term")
        
        XCTAssertEqual(stubView.showHudStyleCalled, .progress)
        
    }
    
    func test_searchRequested_successResponse_shouldCallViewShowSuccessHud() {
        
        stubMusicService.mockResult = NETResult.success(exampleTracks)

        presenter.searchRequested(searchTerm: "Term")
        
        XCTAssertEqual(stubView.showHudStyleCalled, .success)
        
    }
    
    func test_searchRequested_successError_shouldCallViewShowErrorHud() {
        
        stubMusicService.mockResult = NETResult.error(NETError.invalidFormat)
        
        presenter.searchRequested(searchTerm: "Term")
        
        XCTAssertEqual(stubView.showHudStyleCalled, .error)
        
    }
    
    
    func test_searchRequested_shouldCallViewRefresh() {
        
        stubMusicService.mockResult = NETResult.success(exampleTracks)

        presenter.searchRequested(searchTerm: "Term")
        
        XCTAssertTrue(stubView.refreshListCalled)
        
    }
    
    func test_numberOfSections_shouldReturnOne() {
        
        XCTAssertEqual(presenter.numberOfSections, 1)
        
    }
    
    func test_numberOfRows_shouldReturnTheNumberOfFetchedTracks() {
        
        stubMusicService.mockResult = NETResult.success(exampleTracks)
        
        presenter.searchRequested(searchTerm: "Term")
        
        XCTAssertEqual(presenter.numberOfRows, 2)
        
    }
    
    func test_elementAtIndexPath_invalidIndexPath_shouldNotReturn() {
        
        stubMusicService.mockResult = NETResult.success(exampleTracks)
        
        let indexPath = IndexPath(row: 10, section: 0)
        
        presenter.searchRequested(searchTerm: "Term")

        XCTAssertNil(presenter.elementAtIndexPath(indexPath: indexPath))
        
    }
    
    func test_elementAtIndexPath_validIndexPath_shouldReturnExpectedText() {
        
        stubMusicService.mockResult = NETResult.success(exampleTracks)

        let indexPath = IndexPath(row: 1, section: 0)

        presenter.searchRequested(searchTerm: "Term")

        let (returnedTitle, returnedSubtitle, returnedImageURL) = presenter.elementAtIndexPath(indexPath: indexPath)!
        
        XCTAssertEqual(returnedTitle, "Goldfrapp")
        XCTAssertEqual(returnedSubtitle, "Believer")
        XCTAssertEqual(returnedImageURL, "https://lastfm-img2.akamaized.net/i/u/64s/127fdb21d68ea5644f0f98e5c0cc1635.png")
        
    }
    
}
