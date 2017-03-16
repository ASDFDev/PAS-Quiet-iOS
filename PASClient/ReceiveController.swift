//
//  ReceiveController.swift
//  PASClient
//
//  Created by Justin Xin on 15/3/17.
//  Copyright © 2017 Tsubuzaki. All rights reserved.
//

import UIKit
import UIKit.UIDevice
import QuietModemKit
import QuietModemKit.QMFrameReceiver
import QuietModemKit.QMReceiverConfig

class ReceiveController: UIViewController {
    
    @IBOutlet weak var btnReceive: UIButton!
    
    var deviceid:String = UIDevice.current.identifierForVendor!.uuidString
    var receiver: QMFrameReceiver?
    
    override func viewDidLoad() {
        super.viewDidLoad()
   }
    
    override func viewDidDisappear(_ animated: Bool) {
        if (receiver != nil) {
            receiver?.close()
            btnReceive.isEnabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func receiverCallback(_ data: Data?) -> Void
    {
        let alert = UIAlertController(title: String.init(data: (data)!, encoding: String.Encoding.utf8), message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        if (receiver != nil) {
            receiver?.close()
            btnReceive.isEnabled = true
        }
    }
    
    func requestCallback(_: Bool)
    {
        let q:QMReceiverConfig = QMReceiverConfig.init(key: "ultrasonic-experimental")
        receiver = QMFrameReceiver.init(config: q)
        receiver?.setReceiveCallback(receiverCallback)
    }
    
    @IBAction func startReceive(_ sender: UIButton) 
    {
        btnReceive.isEnabled = false
        AVAudioSession.sharedInstance().requestRecordPermission(requestCallback)
    }
    
}

