//
//  MULSearchDetailPresenterTests.swift
//  MatFM
//
//  Created by Mattia Campolese on 26/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation
import XCTest
@testable import MatFM

class MULSearchDetailPresenterTests: XCTestCase {
    
    var mockTrack: MUSTrack!
    var presenter: MULSearchDetailPresenter!
    
    override func setUp() {
        super.setUp()
        mockTrack = exampleTracks.first!
        presenter = MULSearchDetailPresenter(selectedTrack: mockTrack)
    }
    
    override func tearDown() {
        mockTrack = nil
        presenter = nil
        super.tearDown()
    }
    
    func test_title_shouldReturnSelectedArtist() {
        
        XCTAssertEqual(presenter.title, "The Killers")
        
    }
    
    func test_subTitle_shouldReturnSelectedSongName() {
        
        XCTAssertEqual(presenter.subTitle, "Believe Me Natalie")
        
    }
    
    func test_title_shouldReturnSelectedUrl() {
        
        XCTAssertEqual(presenter.urlDetail.absoluteString, "https://www.last.fm/music/The+Killers/_/Believe+Me+Natalie")
        
    }
}
