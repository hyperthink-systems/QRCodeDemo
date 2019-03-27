//
//  QRScannerController.swift
//  QRCodeDemo
//
//  Created by HyperThink Systems on 01/02/19.
//  Copyright © 2019 HyperThink Systems. All rights reserved.
//


import UIKit
import AVFoundation
import AudioToolbox

class QRScannerController: UIViewController {
    
    @IBOutlet var topbar: UIView!
    
    @IBOutlet weak var desc: UILabel!
    var captureSession = AVCaptureSession()
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    private let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                                      AVMetadataObject.ObjectType.code39,
                                      AVMetadataObject.ObjectType.code39Mod43,
                                      AVMetadataObject.ObjectType.code93,
                                      AVMetadataObject.ObjectType.code128,
                                      AVMetadataObject.ObjectType.ean8,
                                      AVMetadataObject.ObjectType.ean13,
                                      AVMetadataObject.ObjectType.aztec,
                                      AVMetadataObject.ObjectType.pdf417,
                                      AVMetadataObject.ObjectType.itf14,
                                      AVMetadataObject.ObjectType.dataMatrix,
                                      AVMetadataObject.ObjectType.interleaved2of5,
                                      AVMetadataObject.ObjectType.qr]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        // Get the back-facing camera for capturing videos
        let deviceDiscoverySession = AVCaptureDevice.default(for: .video)
        
        
        
        guard let captureDevice = deviceDiscoverySession else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session.
            captureSession.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            //            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        // Start video capture.
        captureSession.startRunning()
        
        // Move the message label and top bar to the front
        
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
            

        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helper methods
    
    func launchApp(decodedURL: String) {
        if presentedViewController != nil {
            return
        }
        
        AudioServicesPlaySystemSound(1009)

        let alertPrompt = UIAlertController(title: "Congratulations", message: "Successfully Scanned!!! ", preferredStyle: .actionSheet)
        let confirmAction = UIAlertAction(title: "Lets Go", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Maps") as! MapDetailsViewController
            //vc.newsObj = newsObj
            self.navigationController?.pushViewController(vc,
                                                     animated: true)

        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        alertPrompt.addAction(confirmAction)
        alertPrompt.addAction(cancelAction)
        
        present(alertPrompt, animated: true, completion: nil)
        print("added")
        
     }
}
    
    


extension QRScannerController: AVCaptureMetadataOutputObjectsDelegate {
    
 
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata (or barcode) then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                launchApp(decodedURL: metadataObj.stringValue!)
                print(metadataObj.stringValue!)
                
                link = metadataObj.stringValue!
                
                if metadataObj.stringValue != nil {
                    launchApp(decodedURL: metadataObj.stringValue!)
                    saveData = metadataObj.stringValue
                    print(saveData!)
                    
                 //   UserDefaults.standard.set(URL.self, forKey: "Link")
                   // UserDefaults.standard.set(saveData!, forKey: "login")
                    
                    //saveData.synchronize()
                    
                    let url = saveData
                        UserDefaults.standard.set(url, forKey: "MyApp.lastURL")
                    
                }
                
            }
        }
    }
    
  
    
    
    
    
    
    
    func postMthod() {
        
      //  let dict = ["device":"asguysidghaihwih","siteName":"HTS001","deviceName":"eihgiehghi","solution":"EMS","deviceId":"HTtest123","deviceType":"iudfgiuhigu","latitude":49490845,"longitude":9349003,"gateway":"HTS Gateway","gatewayId":"123456"] as [String: Any]
        
        
        
      /*  let Sensordata: [String: Any] = [ "device": "12442",
                                          "deviceId": "HTtest124",
                                          "deviceName": "21124",
                                          "deviceType": "234234",
                                          "gateway": "HTS Gateway",
                                          "gatewayId": "123456",
                                          "latitude": 12,
                                          "longitude": 10,
                                          "siteName": "HTS001",
                                          "solution": "EMS",
                                          "acc" : [
                                          //  "x" : "\(String(describing: accX!))",
                                          //  "y" : "\(String(describing: accY!))",
                                          //  "z" : "\(String(describing: accZ!))",
                                            "unit" : "mG"
         //   ],
                                        //  "gyro" : [
                                            "x" : "\//(String(describing: gyroX!))",
                                        //    "y" : "\(String(describing: gyroY!))",
                                        //    "z" : "\(String(describing: gyroZ!))",
                                            "unit" : "mdeg/s"
         //   ],
                                         // "mag" : [
                                            "x" : "\//(String(describing: magX!))",//
                                         //   "y" : "\(String(describing: magY!))",
                                          //  "z" : "\(String(describing: magZ!))",
                                            "unit" : "uT"
            ]]
        
        
        
        //create the url with URL
        let url = URL(string: "http://192.168.0.106:3002/qrCode")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        
        do {

            request.httpBody = try JSONSerialization.data(withJSONObject: Sensordata, options: []) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       // request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
               // if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                   // print(json)
                
                let gitData = try JSONDecoder().decode(Lol.self, from: data)
                    print(gitData)
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    */
   
}
}
