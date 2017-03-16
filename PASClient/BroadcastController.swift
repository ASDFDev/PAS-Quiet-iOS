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
    @IBOutlet weak var btnStop: UIButton!
    
    var deviceid:String = UIDevice.current.identifierForVendor!.uuidString
    var transmitter:QMFrameTransmitter?
    var isStopped:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BroadcastController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stopBroadcast(self)
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
            btnStop.isEnabled = true
            let q:QMTransmitterConfig = QMTransmitterConfig.init(key: "ultrasonic-experimental")
            transmitter = QMFrameTransmitter.init(config: q)
            isStopped = false
            DispatchQueue.global().async {
            while (!self.isStopped) {
                self.transmitter?.send(self.txtCode.text?.data(using: String.Encoding.utf8))
                DispatchQueue.main.async {
                }
                sleep(2)
                }
            }
        }
    }
    
    @IBAction func stopBroadcast(_ sender: Any) {
        transmitter?.close()
        isStopped = true
        btnBroadcast.isEnabled = true
        btnStop.isEnabled = false
    }
    
}
