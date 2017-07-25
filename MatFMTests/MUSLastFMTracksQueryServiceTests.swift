//
//  MUSLastFMTracksQueryServiceTests.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import MatFM

class MUSLastFMTracksQueryServiceTests: XCTestCase {
    
    var stubJSONRequester: NETStubJSONRequester!
    var tracksQueryService: MUSLastFMTracksQueryService!
    
    override func setUp() {
        super.setUp()
        stubJSONRequester = NETStubJSONRequester()
        tracksQueryService = MUSLastFMTracksQueryService(jsonRequester: stubJSONRequester)
    }
    
    override func tearDown() {
        stubJSONRequester = nil
        tracksQueryService = nil
        super.tearDown()
    }
    
    func test_searchTrack_shouldCallJSONRequesterWithExpectedURL() {
        
        let expectedURL = URL(string: "http://ws.audioscrobbler.com/2.0/?api_key=39e717d6d65c142d2b440060d9e90055&method=track.search&track=Believe%20Me&format=json")!
        
        tracksQueryService.searchTrack(trackName: "Believe Me") { (_) in }
        
        XCTAssertEqual(stubJSONRequester.requestedURL, expectedURL)
        
    }
    
    func test_searchTrack_jsonRequesterReturnsError_shouldReturnJsonRequesterError() {
        
        stubJSONRequester.mockCompletion = NETResult.error(NETError.invalidResponse)
        
        var errorReturned: NETError?
        tracksQueryService.searchTrack(trackName: "Invalid search") { (result) in
            switch result {
            case .error(let error as NETError):
                errorReturned = error
            default:
                XCTFail()
            }
        }
        
        XCTAssertEqual(errorReturned, NETError.invalidResponse)
        
    }
    
    func test_searchTrack_jsonRequesterReturnsInvalidJSON_shouldReturnEmptyList() {
        
        stubJSONRequester.mockCompletion = NETResult.success(JSON(jsonData))
        
        var tracksReturned: [MUSTrack]?
        tracksQueryService.searchTrack(trackName: "Service Error") { (result) in
            switch result {
            case .success(let tracks):
                tracksReturned = tracks
            case .error(_):
                XCTFail()
            }
        }
        
        XCTAssertEqual(tracksReturned?.count, 0)
        
    }
    
    func test_searchTrack_jsonRequesterReturnsValidJSON_shouldReturnListOfParsedMUSTrack() {
        
        let validListPath = Bundle(for: type(of: self)).path(forResource: "validLastFMTracksListExample", ofType: "json")
        let validList = NSData(contentsOfFile: validListPath!)
        let lastFMValidTrackList = JSON(data: validList! as Data)
        
        stubJSONRequester.mockCompletion = NETResult.success(lastFMValidTrackList)
        
        var tracksReturned: [MUSTrack]?
        tracksQueryService.searchTrack(trackName: "Service Error") { (result) in
            switch result {
            case .success(let tracks):
                tracksReturned = tracks
            case .error(_):
                XCTFail()
            }
        }
        
        XCTAssertEqual(tracksReturned!, exampleTracks)
        
    }
    
}
