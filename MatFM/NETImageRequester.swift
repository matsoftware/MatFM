//
//  NETImageRequester.swift
//  MatFM
//
//  Created by Mattia Campolese on 12/09/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation

protocol NETImageRequesting {
    
    func requestImageData(url: URL, completion: ((NETResult<NSData>) -> Void)?)
    
}

/// Wrapper around NETRequester to perform URL request with an expected UIImage as response
final class NETImageRequester: NETImageRequesting {
    
    private let requesterFactory: NETRequesterFactoryProtocol
    
    private var requesters: [String: NETRequesting] = [:]
    private var cache = NSCache<NSString, NSData>()
    
    
    convenience init() {
        self.init(requesterFactory: NETRequesterFactory())
    }
    
    init(requesterFactory: NETRequesterFactoryProtocol) {
        self.requesterFactory = requesterFactory
    }
    
    func requestImageData(url: URL, completion: ((NETResult<NSData>) -> Void)?) {
        
        if let cachedImageData = cache.object(forKey: NSString(string: url.absoluteString)) {
            completion?(NETResult.success(cachedImageData))
            return
        }
        
        let requester = requesterFactory.makeRequester()
        requesters[url.absoluteString] = requester
        
        requester.request(url: url) { [weak self] (result) in
            
            guard let `self` = self else { return }
            
            switch result {
            case .success(let imageData as NSData):
                self.cache.setObject(imageData, forKey: NSString(string: url.absoluteString))
                completion?(NETResult.success(imageData))
            case .error(let error):
                completion?(NETResult.error(error))
            }
            
        }
        
    }
    
}
