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
        
        let expectedTracks = [
            MUSTrack(name: "Believe Me Natalie",
                     artist: "The Killers",
                     url: "https://www.last.fm/music/The+Killers/_/Believe+Me+Natalie",
                     images: [
                        (.small, url: "https://lastfm-img2.akamaized.net/i/u/34s/26d5ba9edaedf723f0ec6ef2f99878c5.png"),
                        (.medium, url: "https://lastfm-img2.akamaized.net/i/u/64s/26d5ba9edaedf723f0ec6ef2f99878c5.png"),
                        (.large, url: "https://lastfm-img2.akamaized.net/i/u/174s/26d5ba9edaedf723f0ec6ef2f99878c5.png"),
                        (.extralarge, url: "https://lastfm-img2.akamaized.net/i/u/300x300/26d5ba9edaedf723f0ec6ef2f99878c5.png")
                ]),
            MUSTrack(name: "Believer",
                     artist: "Goldfrapp",
                     url: "https://www.last.fm/music/Goldfrapp/_/Believer",
                     images: [
                        (.small, url: "https://lastfm-img2.akamaized.net/i/u/34s/127fdb21d68ea5644f0f98e5c0cc1635.png"),
                        (.medium, url: "https://lastfm-img2.akamaized.net/i/u/64s/127fdb21d68ea5644f0f98e5c0cc1635.png"),
                        (.large, url: "https://lastfm-img2.akamaized.net/i/u/174s/127fdb21d68ea5644f0f98e5c0cc1635.png")
                ])
        ]
        
        XCTAssertEqual(tracksReturned!, expectedTracks)
        
    }
    
}
