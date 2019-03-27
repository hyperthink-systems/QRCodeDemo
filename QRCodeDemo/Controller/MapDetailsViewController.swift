//
//  MapDetailsViewController.swift
//  QRCodeDemo
//
//  Created by HyperThink Systems on 08/03/19.
//  Copyright © 2019 HyperThink Systems. All rights reserved.
//

import UIKit
import GoogleMaps
import CocoaMQTT



class MapDetailsViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate{

    @IBOutlet weak var barButton: UIBarButtonItem!
    @IBOutlet weak var mapDetails: UIView!
    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var lon: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var sensorButton: UIButton!
    
    var mapView: GMSMapView?
    var locationManager = CLLocationManager()
    var mqtt: CocoaMQTT!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //mqtt.allowUntrustCACertificate = true

       // setUpMQTT()
    
        
        sensorButton.layer.cornerRadius = 10


        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: mapDetails.frame.size.width, height: mapDetails.frame.size.height), camera: GMSCameraPosition.camera(withLatitude: 12.914953, longitude: 77.632730, zoom: 18))
        
        
        mapView?.delegate = self
        mapView?.isMyLocationEnabled = true
        
        mapView?.settings.compassButton = true
        mapView?.settings.myLocationButton = true
        mapView?.isBuildingsEnabled = true
        mapView?.isTrafficEnabled = true
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        locationManager.allowsBackgroundLocationUpdates = true
        
        locationManager.pausesLocationUpdatesAutomatically = false
        
        
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
        
        
        self.mapDetails.addSubview(mapView!)
        
        
        
        
    }
    
   
    //Mark: MQTT Service
    
  /*  func setUpMQTT() {
        
        
        let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
        mqtt = CocoaMQTT(clientID: clientID, host: "iot.hyperthings.in", port: 6024)
        mqtt.username = "htsuser"
        mqtt.password = "hts@123"
        mqtt.willMessage = CocoaMQTTWill(topic: "/will", message: "dieout")
        mqtt.backgroundOnSocket = true
       // mqtt.publish("/led", withString: "Hello world")
        mqtt.keepAlive = 60
        mqtt.delegate = self
        mqtt.allowUntrustCACertificate = true
        //mqtt.enableSSL = true
        
        let connected = mqtt.connect()
        print("Connected \(connected)")
        
    }  */
    
    
    
    
    
    
    
    @IBAction func barButtonClicked(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popupVC = storyboard.instantiateViewController(withIdentifier: "notification") as! NotificationsViewController
        popupVC.modalPresentationStyle = .popover
        popupVC.modalTransitionStyle = .crossDissolve
        present(popupVC, animated: true, completion: nil)
        
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    @IBAction func gotoNext(_ sender: Any) {
        
       // let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        //let vc = storyBoard.instantiateViewController(withIdentifier: "next") as? SensorViewController
        //self.present(vc!, animated: true, completion: nil)
        
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
        
        // let userLocation = locations[0] as CLLocation
        
        self.lat.text = String(userLocation.coordinate.latitude)
        self.lon.text = String(userLocation.coordinate.longitude)
        
        
        // Convert location into object with human readable address components
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            
            // Check for errors
            if error != nil {
                
              //  print(error ?? "Unknown Error")
                
            } else {
                
                
                if let placemark = placemarks?[0] {
                    
                    var streetAddress = ""
                    
                    if placemark.subThoroughfare != nil && placemark.thoroughfare != nil {
                        
                        streetAddress = placemark.subThoroughfare! + " " + placemark.thoroughfare!
                        
                       // self.address.text = streetAddress
                        
                    } else {
                        
                      //  print("Unable to find street address")
                        
                    }
                    
                    // Same as above, but for city
                    var city = ""
                    
                    // locality gives you the city name
                    if placemark.locality != nil  {
                        
                        city = placemark.locality!
                        
                     //   self.city.text = city
                        
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
                        
                      //  print("Unable to find zip")
                        
                    }
                    
                    var country = ""
                    
                    if placemark.country != nil {
                        
                        country = placemark.country!
                        
                        self.city.text = country
                        
                    } else {
                        
                     //   print("Unable to find zip")
                        
                    }
                    
                    
                    DispatchQueue.main.async {
                        
         self.address.text =  String("\(streetAddress)\n\(city), \(state) \(zip)")
                        
                    }
                    
                }
                
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       // print("Error \(error)")
    }
}

