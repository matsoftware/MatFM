//
//  MULSearchDetailPresenter.swift
//  MatFM
//
//  Created by Mattia Campolese on 26/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation

protocol MULSearchDetailPresenterProtocol {
    
    var title: String {get}
    
    var subTitle: String {get}
    
    var urlDetail: URL {get}
    
}

/// Presenter for the detail view, responsible to provide the additional informations to display for the selected track.
final class MULSearchDetailPresenter: MULSearchDetailPresenterProtocol {
    
    private let selectedTrack: MUSTrack
    
    init(selectedTrack: MUSTrack) {
        self.selectedTrack = selectedTrack
    }
    
    var title: String {
        return selectedTrack.artist
    }
    
    var subTitle: String {
       return selectedTrack.name
    }
    
    var urlDetail: URL {
        return URL(string: selectedTrack.url)!
    }
    
}
