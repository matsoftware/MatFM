//
//  NETImageRequester.swift
//  MatFM
//
//  Created by Mattia Campolese on 12/09/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation

import UIKit

protocol NETImageRequesting {
    
    func requestImage(url: URL, completion: ((NETResult<UIImage>) -> Void)?)
    
}

/// Wrapper around NETRequester to perform URL request with an expected UIImage as response
final class NETImageRequester: NETImageRequesting {
    
    private let requester: NETRequesting
    
    private var cache = NSCache<NSString, UIImage>()
    
    convenience init() {
        self.init(requester: NETRequester())
    }
    
    init(requester: NETRequesting) {
        self.requester = requester
    }
    
    func requestImage(url: URL, completion: ((NETResult<UIImage>) -> Void)?) {
        
        if let cachedImage = cache.object(forKey: NSString(string: url.absoluteString)) {
            completion?(NETResult.success(cachedImage))
            return
        }
        
        requester.request(url: url) { [weak self] (result) in
            
            guard let `self` = self else { return }
            
            switch result {
            case .success(let data):
                do {
                    let image = try self.parseImageData(data: data)
                    self.cache.setObject(image, forKey: NSString(string: url.absoluteString))
                    completion?(NETResult.success(image))
                } catch let error {
                    completion?(NETResult.error(error))
                }
            case .error(let error):
                completion?(NETResult.error(error))
            }
            
        }
        
    }
    
    private func parseImageData(data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw NETError.invalidFormat
        }
        return image
    }
    
}
