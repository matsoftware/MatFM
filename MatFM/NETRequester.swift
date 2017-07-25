//
//  NETRequester.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation

protocol NETRequesting {
    
    func request(url: URL, completion: ((NETResult<Data>) -> Void)?)
    
}

/// Performs network requests given a valid URL and returns the response in completion block
final class NETRequester: NETRequesting {
    
    private let dispatcher: UTLMainQueueDispatching
    private let session: NETURLSessionProtocol
    
    private var dataTask: URLSessionDataTask?
    
    convenience init() {
        self.init(dispatcher: UTLMainQueueDispatcher(),
                  session: URLSession(configuration: .default))
    }
    
    init(dispatcher: UTLMainQueueDispatching,
         session: NETURLSessionProtocol) {
        self.dispatcher = dispatcher
        self.session = session
    }
    
    func request(url: URL, completion: ((NETResult<Data>) -> Void)?) {
        
        dataTask?.cancel()
        
        dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            
            guard let `self` = self else { return }
            
            defer { self.dataTask = nil }
            
            // URLSession error
            if let error = error {
                completion?(NETResult.error(error))
                return
            }
            
            // Invalid response
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    completion?(NETResult.error(NETError.invalidResponse))
                    return
            }
            
            // Invalid data
            guard let data = data else {
                completion?(NETResult.error(NETError.noData))
                return
            }
            
            // Valid response
            self.dispatcher.async {
                completion?(NETResult.success(data))
            }
            
        }
        
        dataTask?.resume()
        
    }
    
    
}
