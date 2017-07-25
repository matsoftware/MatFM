//
//  NETRequesterTests.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import XCTest
@testable import MatFM

class NETRequesterTests: XCTestCase {
    
    var stubDispatcher: UTLStubMainQueueDispatcher!
    var stubSession: NETStubURLSession!
    var requester: NETRequester!
    
    override func setUp() {
        super.setUp()
        stubDispatcher = UTLStubMainQueueDispatcher()
        stubSession = NETStubURLSession()
        requester = NETRequester(dispatcher: stubDispatcher, session: stubSession)
    }
    
    override func tearDown() {
        stubDispatcher = nil
        stubSession = nil
        requester = nil
        super.tearDown()
    }
    
    func test_request_sessionDataTaskReturnsAnError_shouldPerformCompletionBlockWithNETResultError() {
        
        let mockError = NSError(domain: "Network error", code: 100, userInfo: nil)
        stubSession.mockError = mockError
        
        var responseExpected = false
        requester.request(url: testURL) { (result) in
            switch result {
            case .error(let error as NSError):
                responseExpected = mockError == error
            default:
                XCTFail()
            }
        }
        
        XCTAssertTrue(responseExpected)
        
    }
    
    func test_request_sessionDataTaskReturnsAnInvalidResponse_shouldPerformCompletionBlockWithNETResultError() {
        
        stubSession.mockURLResponse = HTTPURLResponse(url: testURL, statusCode: 300, httpVersion: nil, headerFields: nil)
        
        var errorReturned: NETError?
        requester.request(url: testURL) { (result) in
            switch result {
            case .error(let error as NETError):
                errorReturned = error
            default:
                XCTFail()
            }
        }
        
        XCTAssertEqual(errorReturned, NETError.invalidResponse)
        
    }
    
    func test_request_sessionDataTaskReturnsAValidResponse_emptyData_shouldPerformCompletionBlockWithNETResultError() {
        
        stubSession.mockURLResponse = HTTPURLResponse(url: testURL, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        var errorReturned: NETError?
        requester.request(url: testURL) { (result) in
            switch result {
            case .error(let error as NETError):
                errorReturned = error
            default:
                XCTFail()
            }
        }
        
        XCTAssertEqual(errorReturned, NETError.noData)
        
    }
    
    func test_request_sessionDataTaskReturnsAValidResponse_validData_shouldPerformCompletionBlockWithExpectedResult() {
        
        stubSession.mockURLResponse = HTTPURLResponse(url: testURL, statusCode: 200, httpVersion: nil, headerFields: nil)
        stubSession.mockCompletionData = simpleData
        
        var dataReturned: Data?
        requester.request(url: testURL) { (result) in
            switch result {
            case .success(let data):
                dataReturned = data
            case .error(_):
                XCTFail()
            }
        }
        
        XCTAssertEqual(dataReturned, stubSession.mockCompletionData)
        
    }
    
    func test_request_multipleRequest_shouldCallCancelOnPreviousDataTaskAndCallResume() {
        
        requester.request(url: testURL, completion: nil)
        requester.request(url: testURL, completion: nil)

        XCTAssertTrue(stubSession.mockURLSessionDataTask.cancelCalled)
        XCTAssertTrue(stubSession.mockURLSessionDataTask.resumeCalled)
        
    }
    
}
