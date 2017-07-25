//
//  NETJSONRequesterTests.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import MatFM

class NETJSONRequesterTests: XCTestCase {
    
    var stubRequester: NETStubRequester!
    var jsonRequester: NETJSONRequester!
    
    override func setUp() {
        super.setUp()
        stubRequester = NETStubRequester()
        jsonRequester = NETJSONRequester(requester: stubRequester)
    }
    
    override func tearDown() {
        stubRequester = nil
        jsonRequester = nil
        super.tearDown()
    }
    
    func test_requestJSON_requesterReturnsError_shouldReturnRequesterError() {
        
        stubRequester.mockCompletion = NETResult.error(NETError.invalidResponse)
        
        var errorReturned: NETError?
        jsonRequester.requestJSON(url: testURL) { (result) in
            switch result {
            case .error(let error as NETError):
                errorReturned = error
            default:
                XCTFail()
            }
        }
        
        XCTAssertEqual(errorReturned, NETError.invalidResponse)
        
    }
    
    func test_requestJSON_requesterReturnsInvalidData_shouldReturnNETErrorInvalidFormat() {
        
        stubRequester.mockCompletion = NETResult.success(simpleData)
        
        var errorReturned: NETError?
        jsonRequester.requestJSON(url: testURL) { (result) in
            switch result {
            case .error(let error as NETError):
                errorReturned = error
            default:
                XCTFail()
            }
        }
        
        XCTAssertEqual(errorReturned, NETError.invalidFormat)
        
    }
    
    func test_requestJSON_requesterReturnsValidData_shouldReturnExpectedJSONStruct() {
        
        stubRequester.mockCompletion = NETResult.success(jsonData)
        
        var jsonReturned: JSON?
        jsonRequester.requestJSON(url: testURL) { (result) in
            switch result {
            case .success(let json):
                jsonReturned = json
            case .error(_):
                XCTFail()
            }
        }
        
        XCTAssertEqual(jsonReturned?["first"].stringValue, "Mattia")
        
    }
    
}
