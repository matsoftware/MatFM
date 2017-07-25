//
//  MUSLastFMTracksQueryService.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation
import SwiftyJSON

/// Concrete implementation of the MUSTracksQueryServiceProtocol using the LastFM API. 
/// Returns the list of MUSTrack given a track name
final class MUSLastFMTracksQueryService: MUSTracksQueryServiceProtocol {
    
    private let jsonRequester: NETJSONRequesting
    
    convenience init() {
        self.init(jsonRequester: NETJSONRequester())
    }
    
    init(jsonRequester: NETJSONRequesting) {
        self.jsonRequester = jsonRequester
    }
    
    func searchTrack(trackName: String, completion: ((NETResult<[MUSTrack]>) -> Void)?) {
        
        let url = buildURLRequest(trackName: trackName)
        
        jsonRequester.requestJSON(url: url) { [weak self] (result) in
            
            guard let `self` = self else { return }
            
            switch (result) {
            case .success(let json):
                completion?(.success(self.parseResult(result: json)))
            case .error(let error):
                completion?(.error(error))
            }
        }
        
    }
    
    private func buildURLRequest(trackName: String) -> URL {
        var urlComponents = URLComponents(string: MUSQueryServiceProviders.LastFM.baseURL)!
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: MUSQueryServiceProviders.LastFM.api_key)
        let methodQueryItem = URLQueryItem(name: "method", value: "track.search")
        let trackQueryItem = URLQueryItem(name: "track", value: trackName)
        let formatQueryItem = URLQueryItem(name: "format", value: "json")
        urlComponents.queryItems = [apiKeyQueryItem, methodQueryItem, trackQueryItem, formatQueryItem]
        return urlComponents.url!
    }
    
    private func parseResult(result: JSON) -> [MUSTrack] {
        return result["results"]["trackmatches"]["track"].arrayValue.map {
            let images: [(size: MUSTrack.MUSTrackImageThumbnailSizes, url: String)] = $0["image"].arrayValue.flatMap {
                guard let size = MUSTrack.MUSTrackImageThumbnailSizes(rawValue: $0["size"].stringValue) else { return nil }
                    return (size: size, url: $0["#text"].stringValue)
            }
            return MUSTrack(name: $0["name"].stringValue,
                     artist: $0["artist"].stringValue,
                     url: $0["url"].stringValue,
                     images: images)
        }
    }
    
}
