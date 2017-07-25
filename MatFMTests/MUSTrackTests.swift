//
//  MUSTrackTests.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation
import XCTest
@testable import MatFM

class MUSTrackTests: XCTestCase {
    
    func test_isEqual_shouldReturnFalseIfOneOfThePropertyIsFalse() {
        
        let firstTrack = MUSTrack(name: "Name", artist: "Artist", url: "Url", images: [(.small, "small"),( .medium, "medium")])
        let secondTrack = MUSTrack(name: "Name", artist: "Artist", url: "Url", images: [(.large, "large")])
        
        XCTAssertFalse(firstTrack == secondTrack)

    }
    
    func test_isEqual_shouldReturnTrueIfPropertiesMatch() {
        
        let firstTrack = MUSTrack(name: "Name", artist: "Artist", url: "Url", images: [(.small, "small"),( .medium, "medium")])
        let secondTrack = MUSTrack(name: "Name", artist: "Artist", url: "Url", images: [(.small, "small"),( .medium, "medium")])
        
        XCTAssertTrue(firstTrack == secondTrack)
        
    }
    
}
