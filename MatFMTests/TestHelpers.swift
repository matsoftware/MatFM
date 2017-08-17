//
//  TestHelpers.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import UIKit
@testable import MatFM

var testURL: URL {
    return URL(string: "http://www.matsoftware.it/")!
}

var simpleData: Data {
    return Data(base64Encoded: "SGlyZSBtZSA6KQ==")!
}

var jsonData: Data {
    return Data(base64Encoded: "ew0KICAgImZpcnN0IjogIk1hdHRpYSIsDQogICAic2Vjb25kIjogIkNhbXBvbGVzZSINCn0=")!
}

var imageData: Data {
    let size = CGSize(width: 30, height: 30)
    let color = UIColor.green
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
    color.setFill()
    UIRectFill(rect)
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return UIImagePNGRepresentation(image)!
}

var exampleTracks: [MUSTrack] {
    return [
        MUSTrack(name: "Believe Me Natalie",
                 artist: "The Killers",
                 url: "https://www.last.fm/music/The+Killers/_/Believe+Me+Natalie",
                 images: [
                    (.small, url: "https://lastfm-img2.akamaized.net/i/u/34s/26d5ba9edaedf723f0ec6ef2f99878c5.png"),
                    (.medium, url: "https://lastfm-img2.akamaized.net/i/u/64s/26d5ba9edaedf723f0ec6ef2f99878c5.png"),
                    (.large, url: "https://lastfm-img2.akamaized.net/i/u/174s/26d5ba9edaedf723f0ec6ef2f99878c5.png"),
                    (.extralarge, url: "https://lastfm-img2.akamaized.net/i/u/300x300/26d5ba9edaedf723f0ec6ef2f99878c5.png")
            ]),
        MUSTrack(name: "Believer",
                 artist: "Goldfrapp",
                 url: "https://www.last.fm/music/Goldfrapp/_/Believer",
                 images: [
                    (.small, url: "https://lastfm-img2.akamaized.net/i/u/34s/127fdb21d68ea5644f0f98e5c0cc1635.png"),
                    (.medium, url: "https://lastfm-img2.akamaized.net/i/u/64s/127fdb21d68ea5644f0f98e5c0cc1635.png"),
                    (.large, url: "https://lastfm-img2.akamaized.net/i/u/174s/127fdb21d68ea5644f0f98e5c0cc1635.png")
            ])
    ]
}
