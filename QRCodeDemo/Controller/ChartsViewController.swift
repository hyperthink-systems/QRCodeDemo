//
//  ChartsViewController.swift
//  QRCodeDemo
//
//  Created by HyperThink Systems on 07/02/19.
//  Copyright © 2019 HyperThink Systems. All rights reserved.
//

import UIKit
import Charts

class ChartsViewController: UIViewController {

    var timer = Timer()
    
    @IBOutlet weak var chartView: LineChartView!
    override func viewDidLoad() {
        super.viewDidLoad()

     
        let set_a: LineChartDataSet = LineChartDataSet(values:[ChartDataEntry()], label: "vo")
        set_a.drawCirclesEnabled = false
        set_a.setColor(UIColor.blue)
        
        let set_b: LineChartDataSet = LineChartDataSet(values: [ChartDataEntry()], label: "flow")
        set_b.drawCirclesEnabled = false
        set_b.setColor(UIColor.green)
        
        let set_C: LineChartDataSet = LineChartDataSet(values: [ChartDataEntry()], label: "voice")
        set_b.drawCirclesEnabled = false
        set_b.setColor(UIColor.purple)
        
        self.chartView.data = LineChartData(dataSets: [set_a,set_b, set_C])
        timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    

    var i = 0
    @objc func updateCounter() {
        
       // self.chartView.data?.addEntry(ChartDataEntry(x: Double(0), y: Double(accX!)), dataSetIndex: 0)
       // self.chartView.data?.addEntry(ChartDataEntry(x:Double(0) , y:Double(50)), dataSetIndex: 1)
      //  self.chartView.setVisibleXRange(minXRange: Double(0), maxXRange: Double(100))
      //  self.chartView.notifyDataSetChanged()
      //  self.chartView.moveViewToX(Double(i))
      //  i = i+1
    }

}
