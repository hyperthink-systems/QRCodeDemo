//
//  DeviceDataViewController.swift
//  QRCodeDemo
//
//  Created by HyperThink Systems on 06/02/19.
//  Copyright © 2019 HyperThink Systems. All rights reserved.
//

import UIKit
import CoreMotion
import LocalAuthentication








var gyroX: Double?
var gyroY: Double?
var gyroZ:Double?

var accX: Double?
var accY:Double?
var accZ: Double?

var magX:Double?
var magY:Double?
var magZ:Double?



class DeviceDataViewController: UIViewController {
    
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    var motion = CMMotionManager()
    
    
    
    
    
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        statusLabel.text = "Type of data"
        
    }
    
    @IBAction func startData(_ sender: Any) {
        statusLabel.text = "Accelero Data"
        
        motion.startAccelerometerUpdates()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(DeviceDataViewController.update), userInfo: nil, repeats: true)
        
    }
    
    
    @IBAction func GyroData(_ sender: Any) {
        statusLabel.text = "Gyro Data"
        
        motion.startGyroUpdates()
      
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(DeviceDataViewController.update), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func magnetoMeter(_ sender: Any) {
        
        statusLabel.text = "Magneto Data"
        
        motion.startMagnetometerUpdates()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(DeviceDataViewController.update), userInfo: nil, repeats: true)
        
        }
   
    
    
    
    
    @IBAction func motionManager(_ sender: Any) {
        
        statusLabel.text = "Motion Data"
        
        motion.startDeviceMotionUpdates()
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(DeviceDataViewController.update), userInfo: nil, repeats: true)
        
        
    }
    
    
    
    @IBAction func stopGyro(_ sender: Any) {
        
        self.motion.stopGyroUpdates()
        self.motion.stopAccelerometerUpdates()
        self.motion.stopMagnetometerUpdates()

        
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
            
            self.motion.stopGyroUpdates()
            self.motion.stopAccelerometerUpdates()
            self.motion.stopMagnetometerUpdates()

        }
        
    }
    
    @objc func update() {
        if let accelerometerData = motion.accelerometerData {
            xLabel.text = "X: \(accelerometerData.acceleration.x)"
            yLabel.text = " Y: \(accelerometerData.acceleration.y)"
            zLabel.text = "Z: \(accelerometerData.acceleration.z)"
            
            
            
            accX = accelerometerData.acceleration.x
            accY = accelerometerData.acceleration.y
            accZ = accelerometerData.acceleration.z


        }
        
        
        if let gyroMeterData = motion.gyroData {
            
            xLabel.text = "X: \(gyroMeterData.rotationRate.x)"
            yLabel.text = " Y: \(gyroMeterData.rotationRate.y)"
            zLabel.text = "Z: \(gyroMeterData.rotationRate.z)"
            
     

            gyroX = gyroMeterData.rotationRate.x
            gyroY = gyroMeterData.rotationRate.y
            gyroZ = gyroMeterData.rotationRate.z

        }
        
        if let magnetoMeter = motion.magnetometerData {
            
            xLabel.text = "X: \(magnetoMeter.magneticField.x)"
            yLabel.text = " Y: \(magnetoMeter.magneticField.y)"
            zLabel.text = "Z: \(magnetoMeter.magneticField.z)"
        
            magX = magnetoMeter.magneticField.x
            magY = magnetoMeter.magneticField.y
            magZ = magnetoMeter.magneticField.z

        }
        
        
    }
    
    
}
