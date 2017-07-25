//
//  UTLMainQueueDispatcherTests.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import XCTest
@testable import MatFM

class UTLMainQueueDispatcherTests: XCTestCase {
    
    func test_async_shouldNotExecuteBlockSynchronously() {
        
        let dispatcher = UTLMainQueueDispatcher()
        var blockExecuted = false
        dispatcher.async {
            blockExecuted = true
        }
        
        XCTAssertFalse(blockExecuted)
        
    }
    
    func test_async_shouldExecuteBlockAsynchronously() {
        
        let dispatcher = UTLMainQueueDispatcher()
        let asyncExpectation = expectation(description: "Async block called")
        dispatcher.async {
            asyncExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.25, handler: nil)
        
    }
    
}
