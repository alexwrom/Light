//
//  ViewController.swift
//  Light
//
//  Created by MyMac on 04.03.2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var colorLight: UIColor = UIColor.red
    var isTorch: Bool = true
    @IBOutlet weak var switchLight: UISegmentedControl!
    @IBOutlet weak var btnOnOff: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeLight(_ sender: Any) {
        
        isTorch = switchLight.selectedSegmentIndex == 0
        if isTorch
        {
            if self.view.backgroundColor == UIColor.black
            {
                btnOnOff.setTitle("ON", for: [])
            }
            else
            {
                btnOnOff.setTitle("OFF", for: [])
            }
        }
        else
        {
            btnOnOff.setTitle("NEXT", for: [])
        }
    }
    
    @IBAction func changeOnOff(_ sender: Any) {
        if isTorch
        {
            if btnOnOff.title(for: []) == "ON"
            {
                btnOnOff.setTitle("OFF", for: [])
                self.view.backgroundColor = UIColor.white
            }
            else
            {
                btnOnOff.setTitle("ON", for: [])
                self.view.backgroundColor = UIColor.black
            }
            toggleFlash()
         }
        else
        {
            switch colorLight {
            case UIColor.red:
                colorLight = UIColor.yellow
            case UIColor.yellow:
                colorLight = UIColor.green
            default:
                colorLight = UIColor.red
            }
            self.view.backgroundColor = colorLight
        }
    }
    
    func toggleFlash() {
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        if (device!.hasTorch) {
            do {
                try
                    device?.lockForConfiguration()
                device?.torchMode = device?.torchMode == AVCaptureDevice.TorchMode.on ? .off: .on
                device!.unlockForConfiguration()}
            catch{}
        }
    }
}

