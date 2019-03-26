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
    
    var placemark : CLPlacemark?
    var locationManager:CLLocationManager!

    var data = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        
        locationManager!.allowsBackgroundLocationUpdates = true
        
        locationManager!.pausesLocationUpdatesAutomatically = false
        

        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }

       // UINavigationBar.appearance().barTintColor   = UIColor(108,55,255,1)
        UINavigationBar.appearance().barTintColor   = UIColor(41, 150, 204,1)
        UINavigationBar.appearance().isTranslucent = false
        //navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
        
        // Convert location into object with human readable address components
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            
            // Check for errors
            if error != nil {
                
                print(error ?? "Unknown Error")
                
            } else {
                

                if let placemark = placemarks?[0] {
                    
                    var streetAddress = ""
                    
                    if placemark.subThoroughfare != nil && placemark.thoroughfare != nil {
                        
                        streetAddress = placemark.subThoroughfare! + " " + placemark.thoroughfare!
                        
                    } else {
                        
                      //  print("Unable to find street address")
                        
                    }
                    
                    // Same as above, but for city
                    var city = ""
                    
                    // locality gives you the city name
                    if placemark.locality != nil  {
                        
                        city = placemark.locality!
                        
                    } else {
                        
                      //  print("Unable to find city")
                        
                    }
                    
                    // Do the same for state
                    var state = ""
                    
                    // administrativeArea gives you the state
                    if placemark.administrativeArea != nil  {
                        
                        state = placemark.administrativeArea!
                        
                    } else {
                        
                      //  print("Unable to find state")
                        
                    }
                    
                    // And finally the postal code (zip code)
                    var zip = ""
                    
                    if placemark.postalCode != nil {
                        
                        zip = placemark.postalCode!
                        
                    } else {
                        
                       // print("Unable to find zip")
                        
                    }
                    
                    var country:String = ""
                    
                    if placemark.country != nil {
                        
                        country = placemark.country!
                        
                    } else {
                        
                      //  print("Unable to find zip")
                        
                    }
                    
                    
                  //  print("\(streetAddress)\n\(city), \(state) \(zip)")
                    
                    DispatchQueue.main.async {
                    }
                   
                }
                
            }
        }
    }

    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue) {
        
     
}
    @IBAction func ButtonTapped(_ sender: Any) {
        
        if link == saveData {
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

