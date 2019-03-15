//
//  CustomPlace.swift
//  QRCodeDemo
//
//  Created by HyperThink Systems on 07/03/19.
//  Copyright © 2019 HyperThink Systems. All rights reserved.
//

import Foundation
import GooglePlaces
import GoogleMaps

class CustomPlace: GMSMarker {
    //Initialize with lat and long, then set position equal to the coordinate.
    // 'position' comes from inheriting from GMSMarker, which is google marker.
    init(latitude: Double, longitude: Double, distance: Double, placeName: String) {
        super.init()
        if let lat: CLLocationDegrees = latitude,
            let long: CLLocationDegrees = longitude {
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            position = coordinate
        }
        
        let view = Bundle.main.loadNibNamed("MarkerInfoView", owner: nil, options: nil)?.first as! MarkerInfoView
        // you can set your view's properties here with data you are sending in initializer.
        // Remember if you need to pass more than just latitude and longitude, you need
        // to update initializer.
        // lets say you created 2 outlet as placeNameLabel, and distanceLabel, you can set
        // them like following:
        view.placeNameLabel.text = placeName
        view.distanceLabel.text = distance
        
        // Once your view is ready set iconView property coming from inheriting to
        // your view as following:
        
        iconView = view
        appearAnimation = .pop //not necessarily but looks nice.
        
    }
}
