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
    @IBOutlet weak var btnTryAgain: UIButton!
    @IBOutlet weak var btnContinueAnyway: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblErrorInfo.sizeToFit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "continueWithBypass") {
            let n = segue.destination as! UINavigationController
            let c = n.viewControllers[0] as! LoginController
            c.setBypassServer(setting: true)
        }
    }
    
    @IBAction func continueAnyway(_ sender: Any) {
        self.performSegue(withIdentifier: "continueWithBypass", sender: self)
    }
    
}
