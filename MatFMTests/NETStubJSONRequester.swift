//
//  NETStubJSONRequester.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation
import SwiftyJSON
@testable import MatFM

class NETStubJSONRequester: NETJSONRequesting {
    
    private(set) var requestedURL: URL?
    var mockCompletion: NETResult<JSON>?

    func requestJSON(url: URL, completion: ((NETResult<JSON>) -> Void)?) {
        
        requestedURL = url
        
        if let mockCompletion = mockCompletion {
            completion?(mockCompletion)
        }
        
    }
    
}
