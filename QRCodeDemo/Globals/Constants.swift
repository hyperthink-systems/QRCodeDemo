//
//  Constants.swift
//  QRCodeDemo
//
//  Created by HyperThink Systems on 26/03/19.
//  Copyright © 2019 HyperThink Systems. All rights reserved.
//

import Foundation
import CoreMotion
import UIKit


let defaults = UserDefaults.standard
var link: String? = ""
var saveData: String? = ""
let lastURL = UserDefaults.standard.url(forKey: "MyApp.lastURL")

var timer: Timer!
var timer2: Timer!
var timer3: Timer!
var roll: Double    = 0.0
var pitch: Double   = 0.0
var yaw: Double     = 0.0
var motion = CMMotionManager()
var xAxisArray : [Double]?
var yAxisArray : [Double]?

var accXArray = [Double]()
var accYArray = [Double]()
var accZArray = [Double]()

var gyroXArray = [Double]()
var gyroYArray = [Double]()
var gyroZArray = [Double]()

var magXArray = [Double]()
var magYArray = [Double]()
var magZArray = [Double]()





extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
