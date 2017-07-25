//
//  UTLMainQueueDispatcher.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation

protocol UTLMainQueueDispatching {
    
    func async(block: @escaping (() -> Void))
    
}

/// Wrapper around the DispatchQueue to perform async operations
final class UTLMainQueueDispatcher: UTLMainQueueDispatching {
    
    func async(block: @escaping (() -> Void)) {
        DispatchQueue.main.async {
            block()
        }
    }
    
}
