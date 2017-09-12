//
//  NETRequesterFactory.swift
//  MatFM
//
//  Created by Mattia Campolese on 12/09/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation

protocol NETRequesterFactoryProtocol {
    
    func makeRequester() -> NETRequesting
    
}

final class NETRequesterFactory: NETRequesterFactoryProtocol {
    
    func makeRequester() -> NETRequesting {
        return NETRequester()
    }
    
}
