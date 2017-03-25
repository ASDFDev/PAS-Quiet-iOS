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
    @IBOutlet weak var lblWelcomeText: UILabel!
    @IBOutlet weak var imgBanner: UIImageView!
    
    var bypassServerCheck: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblWelcomeText.sizeToFit()
        if (!bypassServerCheck) {
            Reachability.isConnectedToNetwork { success in
                if success {
                    self.txtUsername.isEnabled = true
                    self.txtPassword.isEnabled = true
                    self.btnLogin.isEnabled = true
                } else {
                    self.performSegue(withIdentifier: "showNonConnection", sender: self)
                }
            }
        } else {
            txtUsername.isEnabled = true
            txtPassword.isEnabled = true
            btnLogin.isEnabled = true
            imgBanner.image = #imageLiteral(resourceName: "TestServerImage")
            lblWelcomeText.text = "Welcome to Setsuna! The Setsuna server is currently not available, and functions may not work as expected."
            lblWelcomeText.sizeToFit()
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
    
    func setBypassServer(setting: Bool) {
        bypassServerCheck = setting
    }
    
    @IBAction func signIn(_ sender: Any) {
        if (self.txtUsername.text == "staff" && self.txtPassword.text == "staff") {
            self.performSegue(withIdentifier: "signInStaff", sender: self)
        } else if (self.txtUsername.text == "student1" && self.txtPassword.text == "student") {
            self.performSegue(withIdentifier: "signInStudent", sender: self)
        } else if (self.txtUsername.text == "student2" && self.txtPassword.text == "student") {
            self.performSegue(withIdentifier: "signInStudent", sender: self)
        } else if (self.txtUsername.text == "admin" && self.txtPassword.text == "admin") {
            self.performSegue(withIdentifier: "signInAdmin", sender: self)
        } else if (self.txtUsername.text == "" || self.txtPassword.text == "") {
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
