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
    
    func elementAtIndexPath(indexPath: IndexPath, completion: @escaping (_ title: String, _ subtitle: String, _ image: UIImage) -> Void)
    
}

/// Presenter responsible to update the passive View component
final class MULSearchTablePresenter: MULSearchTablePresenterProtocol {
    
    weak var view: MULSearchTableViewProtocol?
    
    func searchRequested(searchTerm: String) {
        
    }
    
    var numberOfSections: Int {
        return 0
    }
    
    var numberOfRows: Int {
        return 0
    }
    
    func elementAtIndexPath(indexPath: IndexPath, completion: @escaping (_ title: String, _ subtitle: String, _ image: UIImage) -> Void) {
        
    }
    
}
