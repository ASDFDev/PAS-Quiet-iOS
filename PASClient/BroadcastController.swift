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
    @IBOutlet weak var txtCode: UITextField!
    
    var deviceid:String = UIDevice.current.identifierForVendor!.uuidString
    var transmitter:QMFrameTransmitter?
    var isStopped:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BroadcastController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func startBroadcast(_ sender: Any) {
        if (txtCode.text == "") {
            let alert = UIAlertController(title: "You did not enter a code!", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            btnBroadcast.isEnabled = false
            let q:QMTransmitterConfig = QMTransmitterConfig.init(key: "ultrasonic-experimental")
            transmitter = QMFrameTransmitter.init(config: q)
            transmitter?.send(txtCode.text?.data(using: String.Encoding.utf8))
            CFRunLoopRun()
            transmitter?.close()
            btnBroadcast.isEnabled = true
        }
    }
    
}
