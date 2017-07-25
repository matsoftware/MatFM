//
//  NETImageRequesterTests.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import XCTest
@testable import MatFM

class NETImageRequesterTests: XCTestCase {
    
    var stubRequester: NETStubRequester!
    var imageRequester: NETImageRequester!
    
    override func setUp() {
        super.setUp()
        stubRequester = NETStubRequester()
        imageRequester = NETImageRequester(requester: stubRequester)
    }
    
    override func tearDown() {
        stubRequester = nil
        imageRequester = nil
        super.tearDown()
    }
    
    
    func test_requestImage_requesterReturnsError_shouldReturnRequesterError() {
        
        stubRequester.mockCompletion = NETResult.error(NETError.invalidResponse)
        
        var errorReturned: NETError?
        imageRequester.requestImage(url: testURL) { (result) in
            switch result {
            case .error(let error as NETError):
                errorReturned = error
            default:
                XCTFail()
            }
        }
        
        XCTAssertEqual(errorReturned, NETError.invalidResponse)
        
    }
    
    func test_requestImage_requesterReturnsInvalidData_shouldReturnNETErrorInvalidFormat() {
        
        stubRequester.mockCompletion = NETResult.success(simpleData)
        
        var errorReturned: NETError?
        imageRequester.requestImage(url: testURL) { (result) in
            switch result {
            case .error(let error as NETError):
                errorReturned = error
            default:
                XCTFail()
            }
        }
        
        XCTAssertEqual(errorReturned, NETError.invalidFormat)
        
    }
    
    func test_requestImage_requesterReturnsValidData_shouldReturnExpectedUIImage() {
        
        stubRequester.mockCompletion = NETResult.success(imageData)
        
        var imageReturned: UIImage?
        imageRequester.requestImage(url: testURL) { (result) in
            switch result {
            case .success(let image):
                imageReturned = image
            case .error(_):
                XCTFail()
            }
        }
        
        XCTAssertTrue(NSData(data: UIImagePNGRepresentation(imageReturned!)!).isEqual(NSData(data: imageData)))
        
    }
    
    
}
