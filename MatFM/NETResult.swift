//
//  NETResult.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation

/// Defines the possible responses coming from a request
enum NETResult<T> {
    
    case success(T)
    case error(Error)
    
}
