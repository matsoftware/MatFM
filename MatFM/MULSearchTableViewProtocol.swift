//
//  MULSearchTableViewProtocol.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation

protocol MULSearchTableViewProtocol: class {
 
    func refreshList()

    func showHud(style: MULSearchTableViewHudStyle)
    
}

enum MULSearchTableViewHudStyle {
    case progress
    case error
    case success
}

