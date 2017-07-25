//
//  NETStubRequester.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation
@testable import MatFM

class NETStubRequester: NETRequesting {
    
    private(set) var requestedURL: URL?
    var mockCompletion: NETResult<Data>?
    
    func request(url: URL, completion: ((NETResult<Data>) -> Void)?) {
        
        requestedURL = url
        
        completion?(mockCompletion!)
        
    }
    
}
