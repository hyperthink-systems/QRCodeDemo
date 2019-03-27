//
//  MapsViewController.swift
//  QRCode
//
//  Created by HyperThink Systems on 08/03/19.
//

import UIKit
import GoogleMaps


class MapsViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate{

    
    @IBOutlet weak var newView: UIView!
    
    var mapView: GMSMapView?
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 56), camera: GMSCameraPosition.camera(withLatitude: 12.914953, longitude: 77.632730, zoom: 8))
        
  
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
        
        
        
        print(mapView!)
        
        self.newView.addSubview(mapView!)

    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation :CLLocation = locations[0] as CLLocation
        
         //let userLocation = locations[0] as CLLocation
        
          print(userLocation.coordinate.latitude)
          print(userLocation.coordinate.longitude)
        
        
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
                        
                        print(streetAddress)
                        
                    } else {
                        
                        print("Unable to find street address")
                        
                    }
                    
                    // Same as above, but for city
                    var city = ""
                    
                    // locality gives you the city name
                    if placemark.locality != nil  {
                        
                        city = placemark.locality!
                        print(city)
                        
                    } else {
                        
                        print("Unable to find city")
                        
                    }
                    
                    // Do the same for state
                    var state = ""
                    
                    // administrativeArea gives you the state
                    if placemark.administrativeArea != nil  {
                        
                        state = placemark.administrativeArea!
                        print(state)
                    } else {
                        
                        print("Unable to find state")
                        
                    }
                    
                    // And finally the postal code (zip code)
                    var zip = ""
                    
                    if placemark.postalCode != nil {
                        
                        zip = placemark.postalCode!
                        print(zip)
                    } else {
                        
                        print("Unable to find zip")
                        
                    }
                    
                    var country = ""
                    
                    if placemark.country != nil {
                        
                        country = placemark.country!
                        print(country)
                    } else {
                        
                        print("Unable to find zip")
                        
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

    

}
