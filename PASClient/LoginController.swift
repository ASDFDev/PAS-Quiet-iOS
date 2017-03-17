//
//  LoginController.swift
//  PAS
//
//  Created by Justin Xin on 16/3/17.
//  Copyright © 2017 Tsubuzaki. All rights reserved.
//

import Foundation
import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        Reachability.isConnectedToNetwork { success in
            if success {
            } else {
                let alert = UIAlertController(title: "Please connect to a PAS-enabled network to use this app.", message: "", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Learn more", style: UIAlertActionStyle.default, handler: { action in
                    UIApplication.shared.open(URL.init(string: "https://github.com/emansih/ATS_Backend")!)
                    }
                ))
                alert.addAction(UIAlertAction(title: "Continue anyway", style: UIAlertActionStyle.destructive, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        super.viewDidLoad()
    }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "signInStudent") {
            let n = segue.destination as! UINavigationController
            let c = n.viewControllers[0] as! ReceiveController
            c.updateUserID(newUserID: txtUsername.text!)
        }
    }
    
    @IBAction func signIn(_ sender: Any) {
        if (txtUsername.text == "s10001" && txtPassword.text == "staff") {
        performSegue(withIdentifier: "signInStaff", sender: self)
        } else if (txtUsername.text == "p1000000" && txtPassword.text == "student") {
            performSegue(withIdentifier: "signInStudent", sender: self)
        } else if (txtUsername.text == "admin" && txtPassword.text == "admin") {
            performSegue(withIdentifier: "signInAdmin", sender: self)
        } else if (txtUsername.text == "" || txtPassword.text == "") {
            let alert = UIAlertController(title: "Please enter your username and password", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Try again", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Incorrect username or password", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Try again", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
