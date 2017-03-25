//
//  NonConnectionController.swift
//  Setsuna
//
//  Created by Justin Xin on 25/3/17.
//  Copyright © 2017 Tsubuzaki. All rights reserved.
//

import Foundation
import UIKit

class NonConnectionController: UIViewController {
    
    @IBOutlet weak var lblErrorInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblErrorInfo.sizeToFit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
