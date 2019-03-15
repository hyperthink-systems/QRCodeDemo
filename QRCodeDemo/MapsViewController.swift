//
//  MapsViewController.swift
//  QRCodeDemo
//
//  Created by HyperThink Systems on 08/03/19.
//  Copyright © 2019 HyperThink Systems. All rights reserved.
//

import UIKit
import GoogleMaps

class MapsViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    //    self.mapView.isMyLocationEnabled = true
        
        
        self.mapView.mapType = .normal
        
        self.mapView.isMyLocationEnabled = true
        
        
        self.mapView.settings.compassButton = true
        
        
        self.mapView.settings.myLocationButton = true
        
        
        self.mapView.delegate = self;
    }

}
