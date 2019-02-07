//
//  ViewController.swift
//  QRCodeDemo
//
//  Created by HyperThink Systems on 01/02/19.
//  Copyright © 2019 HyperThink Systems. All rights reserved.
//

import UIKit
import QRCode
import AVFoundation
import QRCodeReader

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {


    @IBOutlet weak var viewPreview: UIView!
    @IBOutlet weak var lblString: UILabel!
    @IBOutlet weak var btnStartStop: UIButton!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        

       // UINavigationBar.appearance().barTintColor   = UIColor(108,55,255,1)
        UINavigationBar.appearance().barTintColor   = UIColor(41, 150, 204,1)
        UINavigationBar.appearance().isTranslucent = false
        //navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]

    }
    
    
    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
extension UIColor {
    convenience init(_ r: Double,_ g: Double,_ b: Double,_ a: Double) {
        self.init(red: CGFloat(r/255), green: CGFloat(g/255), blue: CGFloat(b/255), alpha: CGFloat(a))
    }
}

