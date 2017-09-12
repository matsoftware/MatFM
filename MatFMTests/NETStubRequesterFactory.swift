//
//  NETStubRequesterFactory.swift
//  MatFM
//
//  Created by Mattia Campolese on 12/09/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation
@testable import MatFM

class NETStubRequesterFactory: NETRequesterFactoryProtocol {
    
    var stubRequester = NETStubRequester()
    
    func makeRequester() -> NETRequesting {
        return stubRequester
    }
    
}
