//
//  MUSTrack.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation

/// Model defining a single track with all properties
struct MUSTrack: Equatable {
    
    let name: String
    let artist: String
    let url: String
    let images: [(size: MUSTrackImageThumbnailSizes, url: String)]
    
    enum MUSTrackImageThumbnailSizes: String {
        case small = "small"
        case medium = "medium"
        case large = "large"
        case extralarge = "extralarge"
    }
    
    static func ==(lhs: MUSTrack, rhs: MUSTrack) -> Bool {
        return lhs.name == rhs.name &&
            lhs.artist == rhs.artist &&
            lhs.url == rhs.url &&
            lhs.images.elementsEqual(rhs.images) { (first, second) -> Bool in
                first == second
        }
        
    }
    
}

