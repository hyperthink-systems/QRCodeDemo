//
//  DetailsViewController.swift
//  QRCodeDemo
//
//  Created by HyperThink Systems on 07/03/19.
//  Copyright © 2019 HyperThink Systems. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces

var place: String = ""

class DetailsViewController: UIViewController, GMSMapViewDelegate{

    @IBOutlet weak var maps: GMSMapView!
    @IBOutlet weak var myMaps: GMSMapView!
    
    //var mapView:GMSMapView?
    
  var mapView: GMSMapView!
    
    
    var placemark : CLPlacemark?
    //var locationManager:CLLocationManager!
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
   // var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       // locationManager = CLLocationManager()
       // locationManager.desiredAccuracy = kCLLocationAccuracyBest
       // locationManager.requestAlwaysAuthorization()
       // locationManager.distanceFilter = 50
      //  locationManager.startUpdatingLocation()
       // locationManager.delegate = self
      //  placesClient = GMSPlacesClient.shared()
        
        //let camera = GMSCameraPosition.camera(withLatitude: 51.5287718,
                //                              longitude: -0.2416809,
                        //                      zoom: zoomLevel)
        
        let latitude = 51.5287718
        let longitude = -0.2416809
        
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 14.0)

    //    mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), camera: camera)
        //mapView.settings.myLocationButton = true
       // mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       // mapView.isMyLocationEnabled = true
       // mapView.settings.myLocationButton = true
       // mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)

         self.maps.camera = camera
        
        
        // let customView = UIView(frame: CGRect(x: 0, y: 500 , width: view.frame.size.width, height: 300))
        
  
        
     //   let customView = UIView()
        
       // customView.frame = CGRect(x: 0, y: 600 , width: self.mapView.frame.width, height: 100)

       // customView.backgroundColor = UIColor.gray
        
       // self.mapView.addSubview(customView)

      //  let marker = GMSMarker()
        
       // marker.position = CLLocationCoordinate2D(latitude: 51.5287718, longitude: -0.2416809)
        
      //  marker.title = "Bangalore"
      //  marker.snippet = "India"
     //   marker.map = self.mapView
        
        
        
        //view.addSubview(mapView)
        
        
       

        
  //      mapView.isHidden = true
        
   }
    
    

    
    
    

}


 extension DetailsViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation :CLLocation = locations[0] as CLLocation

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
                        DispatchQueue.main.async {
                            place = city
                        }
                        
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
                    
                    
                    print("\(streetAddress)\n\(city), \(state) \(zip)")
                    
                    DispatchQueue.main.async {
                        
                        //self.place.text =  "\(streetAddress)\n\(city), \(state) \(zip), \(country)"
                    }
                }
                
            }
        }
        
        
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
            
            
            let locationObj = locationManager.location as! CLLocation
            let coord = locationObj.coordinate
            let lattitude = coord.latitude
            let longitude = coord.longitude
            print(" lat in  updating \(lattitude) ")
            print(" long in  updating \(longitude)")
            
            
            
           
            
            
        } else {
            mapView.animate(to: camera)
        }
        
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    
   

}

