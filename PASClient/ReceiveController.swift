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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func receiverCallback(_ data: Data?) -> Void
    {
        print(String.init(describing: data))
        let alert = UIAlertController(title: String.init(describing: data), message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
        CFRunLoopRun()
        if (receiver != nil) {
            receiver?.close()
        }
    }
    
}

