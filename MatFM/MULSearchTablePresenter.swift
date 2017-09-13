//
//  MULSearchTablePresenter.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation


protocol MULSearchTablePresenterProtocol {
    
    func searchRequested(searchTerm: String)
        
    var numberOfSections: Int {get}
    
    var numberOfRows: Int {get}
    
    func elementAtIndex(index: Int) -> (title: String, subtitle: String, thumbnail: String)?
    
    func elementSelected(index: Int)
    
    func imageDataForThumbnailUrl(url: String, completion: @escaping ((Data?) -> Void))
    
}

/// Presenter responsible to update the passive View component
final class MULSearchTablePresenter: MULSearchTablePresenterProtocol {
    
    weak var view: MULSearchTableViewProtocol!
    private let musicQueryService: MUSTracksQueryServiceProtocol
    private let router: MULSearchTableRouterProtocol

    private let imageService: NETImageRequesting
    
    private var trackList: [MUSTrack] = []
    
    init(musicQueryService: MUSTracksQueryServiceProtocol,
         imageService: NETImageRequesting,
        router: MULSearchTableRouterProtocol) {
        self.musicQueryService = musicQueryService
        self.imageService = imageService
        self.router = router
    }
    
    func searchRequested(searchTerm: String) {
        
        view.showHud(style: .progress)
        
        musicQueryService.searchTrack(trackName: searchTerm) { [weak self] (result) in
            
            guard let `self` = self else { return }
            
            switch (result) {
            case .success(let tracks):
                self.trackList = tracks
                self.view.showHud(style: .success)
                break
            case .error(_):
               self.view.showHud(style: .error)
            }
            
            self.view.refreshList()
            
        }
        
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfRows: Int {
        return trackList.count
    }
    
    func elementAtIndex(index: Int) -> (title: String, subtitle: String, thumbnail: String)? {
    
        guard index < trackList.count else { return nil }
        
        let item = trackList[index]
        
        let thumbNailURL = item.images.filter { $0.size == .medium }.first?.url ?? ""
        
        return (item.artist, item.name, thumbNailURL)
        
    }
    
    func elementSelected(index: Int) {
    
        guard index < trackList.count else { return }

        router.presentDetailSearchViewController(track: trackList[index])
        
    }
    
    func imageDataForThumbnailUrl(url: String, completion: @escaping ((Data?) -> Void)) {
        
        guard let url = URL(string: url) else { return }
        
        imageService.requestImageData(url: url) { (result) in
            if case NETResult.success(let data) = result {
                completion(data as Data)
            } else {
                completion(nil)
            }
        }
        
    }
}
