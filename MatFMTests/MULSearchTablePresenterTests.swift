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
    var stubRouter: MULStubSearchTableRouter!
    var stubImageService: NETStubImageRequester!
    var presenter: MULSearchTablePresenter!
    
    override func setUp() {
        super.setUp()
        stubMusicService = MUSStubTracksQueryService()
        stubView = MULStubSearchTableView()
        stubRouter = MULStubSearchTableRouter()
        stubImageService = NETStubImageRequester()
        presenter = MULSearchTablePresenter(musicQueryService: stubMusicService, imageService: stubImageService, router: stubRouter)
        presenter.view = stubView
    }
    
    override func tearDown() {
        presenter = nil
        stubMusicService = nil
        stubImageService = nil
        stubRouter = nil
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
        
        presenter.searchRequested(searchTerm: "Term")

        XCTAssertNil(presenter.elementAtIndex(index: 10))
        
    }
    
    func test_elementAtIndexPath_validIndexPath_shouldReturnExpectedText() {
        
        stubMusicService.mockResult = NETResult.success(exampleTracks)

        presenter.searchRequested(searchTerm: "Term")

        let (returnedTitle, returnedSubtitle, returnedImageURL) = presenter.elementAtIndex(index: 1)!
        
        XCTAssertEqual(returnedTitle, "Goldfrapp")
        XCTAssertEqual(returnedSubtitle, "Believer")
        XCTAssertEqual(returnedImageURL, "https://lastfm-img2.akamaized.net/i/u/64s/127fdb21d68ea5644f0f98e5c0cc1635.png")
        
    }
    
    func test_elementSelected_validIndexPath_shouldPushRightDetailViewController() {
        
        stubMusicService.mockResult = NETResult.success(exampleTracks)
        presenter.searchRequested(searchTerm: "Term")

        presenter.elementSelected(index: 0)
        
        XCTAssertEqual(stubRouter.presentDetailSearchViewControllerCalledWithTrack!, exampleTracks.first!)
        
    }
    
    func test_imageDataForThumbnailsUrl_wrongUrl_shouldNotRequestImageData() {
        
        presenter.imageDataForThumbnailUrl(url: "") { (_) in }
        
        XCTAssertNil(stubImageService.requestedURL)
    }
    
    func test_imageDataForThumbnailsUrl_correctUrl_successDataRetrieving_shouldReturnCompletionWithDataFromService() {
        
        stubImageService.mockResult = NETResult.success(NSData(data: imageData))
        
        var expectedData: Data?
        presenter.imageDataForThumbnailUrl(url: "http://www.google.co.uk") { (data) in
            expectedData = data
        }
        
        XCTAssertEqual(expectedData, imageData)
        
    }
    
    func test_imageDataForThumbnailsUrl_correctUrl_errorInDataRetrieving_shouldReturnCompletionWithNilData() {
        
        stubImageService.mockResult = NETResult.error(NETError.invalidResponse)
        
        var expectedData: Data? = imageData
        presenter.imageDataForThumbnailUrl(url: "http://www.google.co.uk") { (data) in
            expectedData = data
        }
        
        XCTAssertNil(expectedData)
        
    }
    
}
