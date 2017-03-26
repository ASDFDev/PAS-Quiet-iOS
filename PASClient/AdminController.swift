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
        let u:URL = URL.init(string: "https://www.github.com/")!
        // TODO: Universal admin page
        // TODO: Scrap feature
        let r = URLRequest (url: u)
        webMain.loadRequest(r)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

