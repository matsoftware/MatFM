//
//  NETStubURLSession.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation
@testable import MatFM

class NETStubURLSession: NETURLSessionProtocol {
    
    var mockURLSessionDataTask = MockURLSessionDataTask()
    var mockCompletionData: Data?
    var mockURLResponse: URLResponse?
    var mockError: Error?
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask {
        
        completionHandler(mockCompletionData, mockURLResponse, mockError)
        
        return mockURLSessionDataTask
    }
    
}

class MockURLSessionDataTask: URLSessionDataTask {

    private(set) var cancelCalled = false
    private(set) var resumeCalled = false
    
    override func cancel() {
        cancelCalled = true
    }
    
    override func resume() {
        resumeCalled = true
    }
    
}
