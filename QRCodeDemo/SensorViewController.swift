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

    var timer: Timer!
    var timer2: Timer!
    var timer3: Timer!
    var motion = CMMotionManager()
    
    
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

        myChartView.backgroundColor = UIColor.white

        
        myChartView.dragEnabled = true
        myChartView.setScaleEnabled(true)
        myChartView.pinchZoomEnabled = true
        myChartView.backgroundColor = UIColor.white
        myChartView.drawGridBackgroundEnabled = true
        myChartView.xAxis.enabled = true
        myChartView.rightAxis.enabled = false
        myChartView.drawBordersEnabled = true
        myChartView.xAxis.drawAxisLineEnabled = true
        myChartView.xAxis.drawLimitLinesBehindDataEnabled = false
        myChartView.chartDescription?.text = "Accelerometer"
        myChartView.xAxis.gridLineWidth = 1
        myChartView.xAxis.drawGridLinesEnabled = true
        myChartView.leftAxis.drawAxisLineEnabled = true
        myChartView.leftAxis.drawGridLinesEnabled = true
        myChartView.leftAxis.drawLabelsEnabled = true
        myChartView.rightAxis.drawAxisLineEnabled = true
        myChartView.rightAxis.drawGridLinesEnabled = true
        myChartView.animate(xAxisDuration: 2.5)
        
        self.myChartView.delegate = self
        let set_aa: LineChartDataSet = LineChartDataSet(values:[ChartDataEntry()], label: "X")
        set_aa.drawCirclesEnabled = true
        set_aa.setColor(UIColor.red)
        set_aa.lineWidth = 2
        set_aa.setColor(UIColor(red: 255/255, green: 241/255, blue: 46/255, alpha: 1))
        set_aa.fillAlpha = 1
        set_aa.fillColor = .white
        
        let colorTop =  UIColor(red: 253.0/255.0, green: 106.0/255.0, blue: 2.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 254.0/255.0, green: 227.0/255.0, blue: 194.0/255.0, alpha: 1.0).cgColor
        
        let gradientColors = [colorTop, colorBottom] as CFArray
        let colorLocations:[CGFloat] = [0.0, 1.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        set_aa.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        
        
        set_aa.drawFilledEnabled = true
        set_aa.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
            return CGFloat(self.myChartView.leftAxis.axisMinimum)}
        
        
        
        self.myChartView.data = LineChartData(dataSets: [set_aa])
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
         gyroData()
        magData()
    }
    
    func gyroData() {
        GyroChartView.dragEnabled = true
        GyroChartView.setScaleEnabled(true)
        GyroChartView.pinchZoomEnabled = true
        GyroChartView.backgroundColor = UIColor.white
        GyroChartView.drawGridBackgroundEnabled = true
        GyroChartView.xAxis.enabled = true
        GyroChartView.rightAxis.enabled = false
        GyroChartView.drawBordersEnabled = true
        GyroChartView.xAxis.drawAxisLineEnabled = true
        GyroChartView.xAxis.drawLimitLinesBehindDataEnabled = false
        GyroChartView.chartDescription?.text = "GyroMeter"
        GyroChartView.xAxis.gridLineWidth = 1
        GyroChartView.xAxis.drawGridLinesEnabled = true
        GyroChartView.leftAxis.drawAxisLineEnabled = true
        GyroChartView.leftAxis.drawGridLinesEnabled = true
        GyroChartView.leftAxis.drawLabelsEnabled = true
        GyroChartView.rightAxis.drawAxisLineEnabled = true
        GyroChartView.rightAxis.drawGridLinesEnabled = true
        GyroChartView.animate(xAxisDuration: 2.5)
        // myChartView.rightAxis.drawLabelsEnabled = true
        
        self.GyroChartView.delegate = self
        let set: LineChartDataSet = LineChartDataSet(values:[ChartDataEntry()], label: "X")
        set.drawCirclesEnabled = true
        set.circleColors = [UIColor.red]
        set.lineWidth = 2
        set.axisDependency = .left
        //set.setColor(UIColor(red: 255/255, green: 241/255, blue: 46/255, alpha: 1))
        set.fillAlpha = 1
        set.fillColor = .white
        
        let colorTop =  UIColor(red: 75.0/255.0, green: 149.0/255.0, blue: 33/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        
        let gradientColors = [colorTop, colorBottom] as CFArray
        let colorLocations:[CGFloat] = [0.0, 1.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        set.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        
        set.drawFilledEnabled = true // Draw the Gradient
        set.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set.drawFilledEnabled = true
        set.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
            return CGFloat(self.GyroChartView.leftAxis.axisMinimum)}
            
        GyroChartView.data = LineChartData(dataSets: [set])
            self.timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter2), userInfo: nil, repeats: true)
    }

 

    
    
    
    
    
    func magData() {
    
        magChartView.dragEnabled = true
        magChartView.setScaleEnabled(true)
        magChartView.pinchZoomEnabled = true
        magChartView.backgroundColor = UIColor.white
        magChartView.drawGridBackgroundEnabled = true
        magChartView.xAxis.enabled = true
        magChartView.rightAxis.enabled = false
        magChartView.drawBordersEnabled = true
        magChartView.xAxis.drawAxisLineEnabled = true
        magChartView.xAxis.drawLimitLinesBehindDataEnabled = false
        magChartView.chartDescription?.text = "Accelerometer"
        magChartView.xAxis.gridLineWidth = 1
        magChartView.xAxis.drawGridLinesEnabled = true
        magChartView.leftAxis.drawAxisLineEnabled = true
        magChartView.leftAxis.drawGridLinesEnabled = true
        magChartView.leftAxis.drawLabelsEnabled = true
        magChartView.rightAxis.drawAxisLineEnabled = true
        magChartView.rightAxis.drawGridLinesEnabled = true
        
    
    // myChartView.rightAxis.drawLabelsEnabled = true
    
    self.magChartView.delegate = self
        let set: LineChartDataSet = LineChartDataSet(values:[ChartDataEntry()], label: "X")
        set.drawCirclesEnabled = true
        set.lineWidth = 2
        set.circleColors = [UIColor.brown]
        set.axisDependency = .left
        set.setColor(UIColor(red: 255/255, green: 241/255, blue: 46/255, alpha: 1))
        set.fillAlpha = 1
        set.fillColor = .white
        
        
        let colorTop =  UIColor(red: 151.0/255.0, green: 79.0/255.0, blue: 200.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 62.0/255.0, green: 99.0/255.0, blue: 77.0/255.0, alpha: 1.0).cgColor
        
        let gradientColors = [colorTop, colorBottom] as CFArray
        let colorLocations:[CGFloat] = [0.0, 1.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        set.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        
        

        set.drawFilledEnabled = true
        set.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
            return CGFloat(self.magChartView.leftAxis.axisMinimum)}
        magChartView.data = LineChartData(dataSets: [set])

    timer3 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter3), userInfo: nil, repeats: true)
        
    }
    
    // add point
  var i = 0
    
    @objc func updateCounter3() {
        
        
        self.magChartView.data?.addEntry(ChartDataEntry(x: Double(i), y: magXArray[i]), dataSetIndex: 0)
        self.myChartView.data?.addEntry(ChartDataEntry(x:Double(i) , y: Double(magYArray[i])), dataSetIndex: 0)
        self.magChartView.setVisibleXRange(minXRange: Double(1), maxXRange: Double(5))
        self.magChartView.notifyDataSetChanged()
        self.magChartView.moveViewToX(Double(i))
        
        i = i + 1
        
    }
    
    
    @objc func updateCounter2() {
        
        
        self.GyroChartView.data?.addEntry(ChartDataEntry(x: Double(i), y: gyroXArray[i]), dataSetIndex: 0)
        self.GyroChartView.setVisibleXRange(minXRange: Double(1), maxXRange: Double(5))
        self.GyroChartView.notifyDataSetChanged()
        self.GyroChartView.moveViewToX(Double(i))
        
        i = i + 1
        
    }
    @objc func updateCounter() {
        
        
            self.myChartView.data?.addEntry(ChartDataEntry(x: Double(i), y: accXArray[i]), dataSetIndex: 0)
            self.myChartView.setVisibleXRange(minXRange: Double(1), maxXRange: Double(5))
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
