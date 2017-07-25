//
//  UTLStubMainQueueDispatcher.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

@testable import MatFM

/// Performs block synchronously to avoid async and unstable tests
class UTLStubMainQueueDispatcher: UTLMainQueueDispatching {
    
    func async(block: @escaping (() -> Void)) {
        block()
    }

}
