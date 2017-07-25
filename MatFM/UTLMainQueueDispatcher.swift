//
//  UTLMainQueueDispatcher.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation

class UTLMainQueueDispatcher: UTLMainQueueDispatching {
    
    func async(block: @escaping (() -> Void)) {
        DispatchQueue.main.async {
            block()
        }
    }
    
}
