//
//  MULSearchDetailViewController.swift
//  MatFM
//
//  Created by Mattia Campolese on 26/07/2017.
//  Copyright © 2017 Easyfuture LTD. All rights reserved.
//

import UIKit

/// ViewController responsible of displaying the detailed information of the selected track.
final class MULSearchDetailViewController: UIViewController {
    
    var presenter: MULSearchDetailPresenterProtocol!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = presenter.title
        lblSubtitle.text = presenter.subTitle
        webView.loadRequest(URLRequest(url: presenter.urlDetail))
    }
    
}
