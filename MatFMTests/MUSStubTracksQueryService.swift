//
//  MUSStubTracksQueryService.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation
@testable import MatFM

class MUSStubTracksQueryService: MUSTracksQueryServiceProtocol {
    
    private(set) var requestedTrackName: String?
    var mockResult: NETResult<[MUSTrack]>?
    
    func searchTrack(trackName: String, completion: ((NETResult<[MUSTrack]>) -> Void)?) {
        requestedTrackName = trackName
        if let mockResult = mockResult {
            completion?(mockResult)
        }
    }
    
}
