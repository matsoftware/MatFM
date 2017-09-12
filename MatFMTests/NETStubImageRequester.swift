//
//  NETStubImageRequester.swift
//  MatFM
//
//  Created by Mattia Campolese on 12/09/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation

@testable import MatFM

class NETStubImageRequester: NETImageRequesting {
    
    private(set) var requestedURL: URL?
    var mockResult: NETResult<NSData>?
    
    func requestImageData(url: URL, completion: ((NETResult<NSData>) -> Void)?) {
        requestedURL = url
        
        if let mockResult = mockResult {
            completion?(mockResult)
        }
        
    }
    
}
