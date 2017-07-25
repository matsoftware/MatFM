//
//  NETJSONRequester.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol NETJSONRequesting {
    
    func requestJSON(url: URL, completion: ((NETResult<JSON>) -> Void)?)
    
}

/// Wrapper around NETRequester to perform URL request and JSON parsing of the response
final class NETJSONRequester: NETJSONRequesting {
    
    private let requester: NETRequesting
    
    convenience init() {
        self.init(requester: NETRequester())
    }
    
    init(requester: NETRequesting) {
        self.requester = requester
    }
    
    func requestJSON(url: URL, completion: ((NETResult<JSON>) -> Void)?) {
        
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
    
    private func parseDataResponse(data: Data) -> NETResult<JSON> {
        
        let json = JSON(data: data)
        
        guard json.null == nil else {
            return NETResult.error(NETError.invalidFormat)
        }
        
        return NETResult.success(json)

    }
    
}
