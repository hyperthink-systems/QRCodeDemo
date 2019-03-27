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
import CoreLocation


class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, CLLocationManagerDelegate{


    @IBOutlet weak var viewPreview: UIView!
    @IBOutlet weak var lblString: UILabel!
    @IBOutlet weak var btnStartStop: UIButton!
    

    var data = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UINavigationBar.appearance().barTintColor   = UIColor(41, 150, 204,1)
        UINavigationBar.appearance().isTranslucent = false
      

    }
    

    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue) {
        
     
}
    @IBAction func ButtonTapped(_ sender: Any) {
        
        
        let lastURL = UserDefaults.standard.url(forKey: "MyApp.lastURL")
        
        if lastURL != nil {
            print("Items Prints")
            
            UserDefaults.standard.string(forKey: "Key")
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Maps") as? MapDetailsViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            
        } else {
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Scan") as? QRScannerController
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
        
    }
    
}

extension UIColor {
    convenience init(_ r: Double,_ g: Double,_ b: Double,_ a: Double) {
        self.init(red: CGFloat(r/255), green: CGFloat(g/255), blue: CGFloat(b/255), alpha: CGFloat(a))
    }
}

