//
//  SensorViewController.swift
//  QRCodeDemo
//
//  Created by HyperThink Systems on 11/03/19.
//  Copyright © 2019 HyperThink Systems. All rights reserved.
//

import UIKit
import CoreMotion
import Charts

class SensorViewController: UIViewController,ChartViewDelegate{

    let gold = UIColor(hexString: "#ffe700ff")

    
    var timer: Timer!
    var timer2: Timer!
    var timer3: Timer!
    var motion = CMMotionManager()
    var roll: Double    = 0.0
    var pitch: Double   = 0.0
    var yaw: Double     = 0.0
    
    var xAxisArray : [Double]?
    var yAxisArray : [Double]?
    
    
    @IBOutlet weak var magChartView: LineChartView!
    @IBOutlet weak var GyroChartView: LineChartView!
    @IBOutlet weak var myChartView: LineChartView!
    
    
    var accXArray = [Double]()
    var accYArray = [Double]()
    var accZArray = [Double]()
    
    var gyroXArray = [Double]()
    var gyroYArray = [Double]()
    var gyroZArray = [Double]()
    
    var magXArray = [Double]()
    var magYArray = [Double]()
    var magZArray = [Double]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        startData()
        myChartView.layer.cornerRadius = 10
        GyroChartView.layer.cornerRadius = 10
        magChartView.layer.cornerRadius = 10

        myChartView.backgroundColor = UIColor(red: 24/255, green: 33/255, blue: 46/255, alpha: 1)
      
        myChartView.dragEnabled = true
        myChartView.setScaleEnabled(true)
        myChartView.pinchZoomEnabled = true
        myChartView.drawGridBackgroundEnabled = false
        myChartView.xAxis.enabled = false
        myChartView.rightAxis.enabled = false
        myChartView.xAxis.drawAxisLineEnabled = false
        myChartView.xAxis.drawLimitLinesBehindDataEnabled = false
        myChartView.chartDescription?.text = "Accelerometer"
        myChartView.xAxis.gridLineWidth = 1
        myChartView.xAxis.drawGridLinesEnabled = true
        myChartView.leftAxis.drawAxisLineEnabled = true
        myChartView.leftAxis.drawGridLinesEnabled = false
        myChartView.rightAxis.drawLabelsEnabled = true
        myChartView.rightAxis.drawAxisLineEnabled = true
        myChartView.rightAxis.drawGridLinesEnabled = false
        myChartView.xAxis.granularityEnabled = true
        myChartView.leftAxis.axisMaximum = 5
        myChartView.leftAxis.axisMinimum = 5
        myChartView.drawBordersEnabled = true
        myChartView.borderColor = UIColor.darkGray
        myChartView.legend.textColor = UIColor.white
        

        myChartView.xAxis.labelTextColor = UIColor(red: 220/255, green: 199/255, blue: 111/255, alpha: 1)
        
        myChartView.leftAxis.labelTextColor = UIColor(red: 220/255, green: 199/255, blue: 111/255, alpha: 1)
        
        
        let colorTop =  UIColor(red: 110/255, green: 155/255, blue: 95/255, alpha: 1).cgColor
        let colorBottom = UIColor(red: 226/255, green: 150/255, blue: 238/255, alpha: 1).cgColor
        
        let gradientColors = [colorTop, colorBottom] as CFArray
        let colorLocations:[CGFloat] = [0.0, 1.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        
        self.myChartView.delegate = self
        let set_aa: LineChartDataSet = LineChartDataSet(values:[ChartDataEntry()], label: "Accelerometer")
        set_aa.drawCirclesEnabled = true
        set_aa.setColor(UIColor(red: 220/255, green: 199/255, blue: 111/255, alpha: 0.3))
        set_aa.lineWidth = 2
        set_aa.setCircleColor(UIColor.orange)
        //set_aa.setColor(UIColor(red: 220/255, green: 199/255, blue: 111/255, alpha: 1))
        set_aa.mode = .cubicBezier
        set_aa.valueColors = [UIColor.green]
        set_aa.drawValuesEnabled = true
        set_aa.drawFilledEnabled = true
        set_aa.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        set_aa.fillAlpha = 0.2
        
        
        self.myChartView.data = LineChartData(dataSets: [set_aa])
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
         gyroData()
        magData()
    }
    
    
    func gyroData() {
        
        
        let colorTop =  UIColor(red: 21/255, green: 157/255, blue: 60/255, alpha: 1).cgColor
        let colorBottom = UIColor(red: 215/255, green: 127/255, blue: 115/255, alpha: 1).cgColor
        
        let gradientColors = [colorTop, colorBottom] as CFArray
        let colorLocations:[CGFloat] = [0.0, 1.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        
        GyroChartView.backgroundColor = UIColor(red: 24/255, green: 33/255, blue: 46/255, alpha: 1)
        GyroChartView.dragEnabled = true
        GyroChartView.setScaleEnabled(true)
        GyroChartView.pinchZoomEnabled = true
        GyroChartView.drawGridBackgroundEnabled = false
        GyroChartView.xAxis.enabled = false
        GyroChartView.rightAxis.enabled = false
        GyroChartView.xAxis.drawAxisLineEnabled = false
        GyroChartView.xAxis.drawLimitLinesBehindDataEnabled = false
        GyroChartView.xAxis.gridLineWidth = 1
        GyroChartView.xAxis.drawGridLinesEnabled = false
        GyroChartView.leftAxis.drawAxisLineEnabled = true
        GyroChartView.leftAxis.drawGridLinesEnabled = false
        GyroChartView.rightAxis.drawLabelsEnabled = true
        GyroChartView.rightAxis.drawAxisLineEnabled = true
        GyroChartView.leftAxis.axisMinimum = -5
        GyroChartView.leftAxis.axisMaximum = 5
        GyroChartView.rightAxis.drawAxisLineEnabled = true
        GyroChartView.rightAxis.drawGridLinesEnabled = false
        GyroChartView.legend.textColor = UIColor.white
        GyroChartView.borderColor = UIColor.darkGray
        GyroChartView.xAxis.labelTextColor = UIColor(red: 220/255, green: 199/255, blue: 111/255, alpha: 1)
        GyroChartView.leftAxis.labelTextColor = UIColor(red: 220/255, green: 199/255, blue: 111/255, alpha: 1)
        GyroChartView.drawBordersEnabled = true
        let currencyNumberFormatter = NumberFormatter()
        currencyNumberFormatter.numberStyle = .decimal
        currencyNumberFormatter.minimumFractionDigits = 2
        currencyNumberFormatter.maximumFractionDigits = 2
        
        //barChartDataSet.valueFormatter = currencyNumberFormatter
        
        
        self.GyroChartView.delegate = self
        let set: LineChartDataSet = LineChartDataSet(values:[ChartDataEntry()], label: "Gyrometer")
        set.drawCirclesEnabled = true
        set.lineWidth = 2
        set.setColor(UIColor(red: 255.0/255.0, green: 165.0/255.0, blue: 0.0/255.0, alpha: 0.2))
        
        set.setCircleColor(UIColor.orange)
        
        set.valueColors = [UIColor.green]
        set.mode = .cubicBezier
        set.drawValuesEnabled = true
        
        
        set.drawFilledEnabled = true
        set.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        set.fillAlpha = 0.2
        
        GyroChartView.data = LineChartData(dataSets: [set])
        set.valueFormatter = currencyNumberFormatter as? IValueFormatter
        timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter2), userInfo: nil, repeats: true)
        
    }

 

   
    
    
    
    
    func magData() {
        
        
        let coloTop = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8).cgColor
        let colorBottom = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1).cgColor
        let gradientColors = [coloTop, colorBottom] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [0.7, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
       // lineChartDataSet.drawFilledEnabled = true // Draw the Gradient
        
        magChartView.backgroundColor = UIColor(red: 24/255, green: 33/255, blue: 46/255, alpha: 1)
        magChartView.dragEnabled = true
        magChartView.setScaleEnabled(true)
        magChartView.pinchZoomEnabled = true
        magChartView.drawGridBackgroundEnabled = false
        magChartView.xAxis.enabled = false
        magChartView.rightAxis.enabled = false
        magChartView.xAxis.drawAxisLineEnabled = false
        magChartView.xAxis.drawLimitLinesBehindDataEnabled = true
        magChartView.xAxis.gridLineWidth = 1
        magChartView.xAxis.drawGridLinesEnabled = true
        magChartView.leftAxis.drawAxisLineEnabled = true
        
        magChartView.leftAxis.drawGridLinesEnabled = false
        magChartView.rightAxis.drawLabelsEnabled = true
        magChartView.drawBordersEnabled = true
        magChartView.borderColor = UIColor.darkGray
        magChartView.leftAxis.axisMaximum = 5
        magChartView.leftAxis.axisMaximum = 5
        magChartView.rightAxis.drawAxisLineEnabled = true
        magChartView.rightAxis.drawGridLinesEnabled = false
        magChartView.legend.textColor = UIColor.white
        magChartView.xAxis.labelTextColor = UIColor(red: 220/255, green: 199/255, blue: 111/255, alpha: 1)
             magChartView.leftAxis.labelTextColor = UIColor(red: 220/255, green: 199/255, blue: 111/255, alpha: 1)
        
        self.magChartView.delegate = self
        let set: LineChartDataSet = LineChartDataSet(values:[ChartDataEntry()], label: "Magnetometer")
        set.drawCirclesEnabled = true
        set.setColor(UIColor(red: 220/255, green: 199/255, blue: 111/255, alpha: 0.3))
        set.lineWidth = 2
        set.valueColors = [UIColor.green]
        set.setCircleColor(UIColor.orange)
        set.mode = .cubicBezier
        set.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0) // Set the Gradient
        set.drawFilledEnabled = true
        set.fillAlpha = 0.3
        
        magChartView.data = LineChartData(dataSets: [set])

    timer3 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter3), userInfo: nil, repeats: true)
        
    }
    
    // add point
  var i = 0
    
    @objc func updateCounter3() {
        self.magChartView.data?.addEntry(ChartDataEntry(x: Double(i), y: magXArray[i]), dataSetIndex: 0)
        self.magChartView.setVisibleXRange(minXRange: Double(1), maxXRange: Double(8))
        self.magChartView.notifyDataSetChanged()
        self.magChartView.moveViewToX(Double(i))
        i = i + 1
    }
    
    
    @objc func updateCounter2() {
        
        self.GyroChartView.data?.addEntry(ChartDataEntry(x: Double(i), y: gyroXArray[i]), dataSetIndex: 0)
        self.GyroChartView.setVisibleXRange(minXRange: Double(1), maxXRange: Double(8))
        self.GyroChartView.notifyDataSetChanged()
        self.GyroChartView.moveViewToX(Double(i))
        i = i + 1
        
    }
    @objc func updateCounter() {
            self.myChartView.data?.addEntry(ChartDataEntry(x: Double(i), y: accXArray[i]), dataSetIndex: 0)
            self.myChartView.setVisibleXRange(minXRange: Double(1), maxXRange: Double(8))
            self.myChartView.notifyDataSetChanged()
            self.myChartView.moveViewToX(Double(i))
        i = i + 1
    }
    
    

    func startData() {
        
        motion.startAccelerometerUpdates()
        motion.startGyroUpdates()
        motion.startMagnetometerUpdates()

        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(SensorViewController.update), userInfo: nil, repeats: true)
        
    }
    
    private func roundDouble(value: Double) -> Double {
        return round(1000 * value)/100
    }
    
    @objc func update() {
        if let accelerometerData = motion.accelerometerData {
            DispatchQueue.main.async {
                
                self.accXArray.append(self.roundDouble(value: accelerometerData.acceleration.x))
                self.accYArray.append(self.roundDouble(value: accelerometerData.acceleration.y))
                self.accZArray.append(self.roundDouble(value: accelerometerData.acceleration.z))
                
                
            }
        }

        if let gyroMeterData = motion.gyroData {
        
            gyroXArray.append(self.roundDouble(value: gyroMeterData.rotationRate.x))
            gyroYArray.append(self.roundDouble(value: gyroMeterData.rotationRate.y))
            gyroZArray.append(self.roundDouble(value: gyroMeterData.rotationRate.z))
       
        }
        
        if let magnetoMeter = motion.magnetometerData {
            
            DispatchQueue.main.async {
                
                self.magXArray.append(self.roundDouble(value: magnetoMeter.magneticField.x))
                self.magYArray.append(self.roundDouble(value: magnetoMeter.magneticField.y))
                self.magZArray.append(self.roundDouble(value: magnetoMeter.magneticField.z))
                
            
            }
            
        }
 
    }

}



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
