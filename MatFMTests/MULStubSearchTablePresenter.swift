//
//  MULStubSearchTablePresenter.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import UIKit
@testable import MatFM

class MULStubSearchTablePresenter: MULSearchTablePresenterProtocol {
    
    private(set) var searchRequestedTerm: String?
    private(set) var elementIndexPath: IndexPath?
    
    var mockNumberOfSections = 10
    var mockNumberOfRows = 20
    var mockTitle: String = "mockTitle"
    var mockSubTitle: String = "mockSubtitle"
    var mockImage: String = "mockImageURL"
    
    func searchRequested(searchTerm: String) {
        searchRequestedTerm = searchTerm
    }
    
    var numberOfSections: Int {
        return mockNumberOfSections
    }
    
    var numberOfRows: Int {
        return mockNumberOfRows
    }
    
    func elementAtIndexPath(indexPath: IndexPath) -> (title: String, subtitle: String, thumbnail: String)? {
        elementIndexPath = indexPath
        return (mockTitle, mockSubTitle, mockImage)
    }
    
}
