//
//  ReceiveController.swift
//  PAS
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
    
    // HTTP Response Codes
    //
    // 429 == Submission already exists
    // 200 == Submission success
    // 500 == Submission error
    
    let atsURL:String = "http://ats.nearby.com.sg"
    var deviceid:String = UIDevice.current.identifierForVendor!.uuidString
    var userid:String = ""
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
    
    public func updateUserID (newUserID: String) {
        userid = newUserID
    }
    
    func receiverCallback(_ data: Data?) -> Void
    {
        let p:String = "device_id=" + deviceid + "&username=" + userid + "&attendance_code=" + String.init(data: (data)!, encoding: String.Encoding.utf8)!
        let u: URL = URL.init(string: atsURL + "/AttendanceDatabase.php")!
        var r:URLRequest = URLRequest(url: u)
        r.httpMethod = "POST"
        r.httpBody = p.data(using: String.Encoding.utf8, allowLossyConversion: false)
        let task = URLSession.shared.dataTask(with: r) { data, response, error in
            guard let _ = data, error == nil else {
                let alert = UIAlertController(title: "Unknown error, please try again later.", message: "", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            if let t = response as? HTTPURLResponse {
                switch (t.statusCode) {
                case 200:
                    let alert = UIAlertController(title: "Welcome to class!", message: "", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                case 429:
                    let alert = UIAlertController(title: "You cannot submit your attendance twice!", message: "", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                default:
                    let alert = UIAlertController(title: ("Submission error, please try again later. Error: " + String.init(t.statusCode)), message: "", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        task.resume()
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

