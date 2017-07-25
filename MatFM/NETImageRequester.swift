//
//  NETImageRequester.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import UIKit

protocol NETImageRequesting {
    
    func requestImage(url: URL, completion: ((NETResult<UIImage>) -> Void)?)

}

/// Wrapper around NETRequester to perform URL request with an expected UIImage as response
final class NETImageRequester: NETImageRequesting {
    
    private let requester: NETRequesting
    
    convenience init() {
        self.init(requester: NETRequester())
    }
    
    init(requester: NETRequesting) {
        self.requester = requester
    }

    func requestImage(url: URL, completion: ((NETResult<UIImage>) -> Void)?) {
        
        requester.request(url: url) { [weak self] (result) in
            
            guard let `self` = self else { return }
            
            switch result {
            case .success(let data):
                completion?(self.parseDataResponse(data: data))
            case .error(let error):
                completion?(NETResult.error(error))
            }
            
        }
        
    }
    
    func parseDataResponse(data: Data) -> NETResult<UIImage> {
        guard let image = UIImage(data: data) else {
            return NETResult.error(NETError.invalidFormat)
        }
        return NETResult.success(image)
    }
    
}
