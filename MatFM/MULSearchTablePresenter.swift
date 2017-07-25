//
//  MULSearchTablePresenter.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import UIKit

protocol MULSearchTablePresenterProtocol {
    
    func searchRequested(searchTerm: String)
        
    var numberOfSections: Int {get}
    
    var numberOfRows: Int {get}
    
    func elementAtIndexPath(indexPath: IndexPath) -> (title: String, subtitle: String, thumbnail: String)?
    
}

/// Presenter responsible to update the passive View component
final class MULSearchTablePresenter: MULSearchTablePresenterProtocol {
    
    weak var view: MULSearchTableViewProtocol!
    private let musicQueryService: MUSTracksQueryServiceProtocol
    
    private var trackList: [MUSTrack] = []
    
    init(musicQueryService: MUSTracksQueryServiceProtocol) {
        self.musicQueryService = musicQueryService
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
    
    func elementAtIndexPath(indexPath: IndexPath) -> (title: String, subtitle: String, thumbnail: String)? {
    
        guard indexPath.row < trackList.count else { return nil }
        
        let item = trackList[indexPath.row]
        
        let thumbNailURL = item.images.filter { $0.size == .medium }.first?.url ?? ""
        
        return (item.artist, item.name, thumbNailURL)
        
    }
    
}
