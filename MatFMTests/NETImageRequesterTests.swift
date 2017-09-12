//
//  NETImageRequesterTests.swift
//  MatFM
//
//  Created by Mattia Campolese on 12/09/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation
import XCTest
@testable import MatFM

class NETImageRequesterTests: XCTestCase {
    
    var stubRequesterFactory: NETStubRequesterFactory!
    var imageRequester: NETImageRequester!
    
    override func setUp() {
        super.setUp()
        stubRequesterFactory = NETStubRequesterFactory()
        imageRequester = NETImageRequester(requesterFactory: stubRequesterFactory)
    }
    
    override func tearDown() {
        stubRequesterFactory = nil
        imageRequester = nil
        super.tearDown()
    }
    
    //MARK: No cached data
    
    func test_requestImage_requesterReturnsError_shouldReturnRequesterError() {
        
        stubRequesterFactory.stubRequester.mockCompletion = NETResult.error(NETError.invalidResponse)
        
        var errorReturned: NETError?
        imageRequester.requestImageData(url: testURL) { (result) in
            switch result {
            case .error(let error as NETError):
                errorReturned = error
            default:
                XCTFail()
            }
        }
        
        XCTAssertEqual(errorReturned, NETError.invalidResponse)
        
    }
    
    func test_requestImage_requesterReturnsValidData_shouldReturnExpectedData() {
        
        stubRequesterFactory.stubRequester.mockCompletion = NETResult.success(imageData)
        
        var dataReturned: NSData?
        imageRequester.requestImageData(url: testURL) { (result) in
            switch result {
            case .success(let image):
                dataReturned = image
            case .error(_):
                XCTFail()
            }
        }
        
        XCTAssertEqual(dataReturned!, NSData(data: imageData))
        
    }
    
    //MARK: Cached data
    
    func test_requestImage_imageWasRequestedBefore_shouldReturnCachedData_shouldNotCallRequester() {
        
        stubRequesterFactory.stubRequester.mockCompletion = NETResult.success(imageData)
        imageRequester.requestImageData(url: testURL) { (_) in }
        stubRequesterFactory.stubRequester.mockCompletion = NETResult.error(NETError.invalidResponse)
        
        imageRequester.requestImageData(url: testURL) { (_) in }

        var dataReturned: NSData?
        imageRequester.requestImageData(url: testURL) { (result) in
            switch result {
            case .success(let image):
                dataReturned = image
            default:
                XCTFail()
            }
        }
        
        XCTAssertEqual(dataReturned!, NSData(data: imageData))
        
    }
    
}
