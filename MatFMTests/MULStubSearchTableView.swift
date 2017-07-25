//
//  MULStubSearchTableView.swift
//  MatFM
//
//  Created by Mattia Campolese on 25/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import Foundation
@testable import MatFM

class MULStubSearchTableView: MULSearchTableViewProtocol {
    
    private(set) var refreshListCalled = false
    private(set) var showHudStyleCalled: MULSearchTableViewHudStyle?
    
    func showHud(style: MULSearchTableViewHudStyle) {
        showHudStyleCalled = style
    }
    
    func refreshList() {
        refreshListCalled = true
    }
    
}
