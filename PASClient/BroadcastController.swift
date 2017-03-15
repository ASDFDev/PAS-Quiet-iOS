//
//  BroadcastController.swift
//  PASClient
//
//  Created by Justin Xin on 15/3/17.
//  Copyright © 2017 Tsubuzaki. All rights reserved.
//

import UIKit
import UIKit.UIDevice
import QuietModemKit
import QuietModemKit.QMFrameTransmitter
import QuietModemKit.QMTransmitterConfig

class BroadcastController: UIViewController {

    @IBOutlet weak var btnBroadcast: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var txtCode: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var deviceid:String = UIDevice.current.identifierForVendor!.uuidString
    var transmitter:QMFrameTransmitter?
    var isStopped:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BroadcastController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        btnBroadcast.isHidden = false
        txtCode.isHidden = false
        activityIndicator.isHidden = true
        btnStop.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func startBroadcast(_ sender: UIButton) {
        if (txtCode.text == "") {
            let alert = UIAlertController(title: "You did not enter a code!", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Ensure that your volume is turned up to broadcast your code. ", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            btnBroadcast.isHidden = true
            txtCode.isHidden = true
            activityIndicator.isHidden = false
            btnStop.isHidden = false
            let q:QMTransmitterConfig = QMTransmitterConfig.init(key: "ultrasonic-experimental")
            QMFrameTransmitter.init(config: q)
            transmitter?.send(self.txtCode.text?.data(using: String.Encoding.utf8))
            CFRunLoopRun()
            // transmitter?.close()
        }
    }
    
    @IBAction func stopBroadcast(_ sender: Any) {
        isStopped = true
        transmitter?.close()
        btnBroadcast.isHidden = false
        txtCode.isHidden = false
        activityIndicator.isHidden = true
        btnStop.isHidden = true
    }
    
}
