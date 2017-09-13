//
//  MULStubSearchTablePresenter.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation
@testable import MatFM

class MULStubSearchTablePresenter: MULSearchTablePresenterProtocol {
    
    private(set) var searchRequestedTerm: String?
    private(set) var elementIndex: Int?
    private(set) var elementSelectedIndex: Int?
    private(set) var imageDataCalledUrl: String?
    var expectedImageData: Data?
    
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
    
    func elementAtIndex(index: Int) -> (title: String, subtitle: String, thumbnail: String)? {
        elementIndex = index
        return (mockTitle, mockSubTitle, mockImage)
    }
    
    func imageDataForThumbnailUrl(url: String, completion: @escaping ((Data?) -> Void)) {
        imageDataCalledUrl = url
        completion(expectedImageData)
    }
    
    func elementSelected(index: Int) {
        elementSelectedIndex = index
    }
    
}
