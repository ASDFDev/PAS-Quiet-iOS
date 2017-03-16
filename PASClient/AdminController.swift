//
//  AdminController.swift
//  PAS
//
//  Created by Justin Xin on 15/3/17.
//  Copyright © 2017 Tsubuzaki. All rights reserved.
//

import UIKit

class AdminController: UIViewController {
    
    @IBOutlet weak var webMain: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let u:URL = URL.init(string: "http://ats.nearby.com.sg/phpmyadmin")!
        let r = URLRequest (url: u)
        webMain.loadRequest(r)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

