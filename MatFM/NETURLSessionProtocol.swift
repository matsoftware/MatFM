//
//  NETURLSessionProtocol.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation

/// Interface that exposes the public method in URLSession needed to perform dataTask with URL
protocol NETURLSessionProtocol {
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask
    
}

extension URLSession: NETURLSessionProtocol {}
