//
//  NETStubImageRequester.swift
//  MatFM
//
//  Created by Mattia Campolese on 12/09/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation

import UIKit
@testable import MatFM

class NETStubImageRequester: NETImageRequesting {
    
    private(set) var requestedURL: URL?
    var mockResult: NETResult<UIImage>?
    
    func requestImage(url: URL, completion: ((NETResult<UIImage>) -> Void)?) {
        requestedURL = url
        
        if let mockResult = mockResult {
            completion?(mockResult)
        }
        
    }
    
}
