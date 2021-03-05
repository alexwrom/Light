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
        swLight()
    }
    
    @IBAction func changeOnOff(_ sender: Any) {
        onOff()
    }
    // Change Light's type
    func swLight(){
        var btnText =  btnOnOff.title(for: [])
        isTorch = switchLight.selectedSegmentIndex == 0
        if isTorch {
            self.view.backgroundColor = UIColor.black
            btnText =  "ON"
        }
        else {
            if btnText ==  "OFF"{
                toggleFlash()
            }
            btnText =  "NEXT"
            
        }
        btnOnOff.setTitle(btnText, for: [])
    }
    
    // On/ Off torch or next color background
    func onOff(){
        if isTorch {
            if btnOnOff.title(for: []) == "ON" {
                btnOnOff.setTitle("OFF", for: [])
                self.view.backgroundColor = UIColor.white
            }
            else {
                btnOnOff.setTitle("ON", for: [])
                self.view.backgroundColor = UIColor.black
            }
            toggleFlash()
        }
        else {
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
    // On/ Off device torch
    func toggleFlash() {
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        if device != nil{
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
}

