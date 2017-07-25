//
//  MUSTracksQueryServiceProtocol.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol MUSTracksQueryServiceProtocol {
    
    func searchTrack(trackName: String, completion: ((NETResult<[MUSTrack]>) -> Void)?)
    
}
