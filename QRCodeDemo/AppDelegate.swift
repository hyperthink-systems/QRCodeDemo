//
//  AppDelegate.swift
//  QRCodeDemo
//
//  Created by HyperThink Systems on 01/02/19.
//  Copyright © 2019 HyperThink Systems. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CocoaMQTT

var mqttMsg: String? = ""
var mqttt: CocoaMQTT!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        GMSServices.provideAPIKey("AIzaSyBzZmAYOqUtO-JKW7-hbQNC3pvUOvLxmtw")
        //GMSPlacesClient.provideAPIKey("AIzaSyBzZmAYOqUtO-JKW7-hbQNC3pvUOvLxmtw")
   
      
            
            let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
            mqttt = CocoaMQTT(clientID: clientID, host: "iot.hyperthings.in", port: 6024)
            mqttt.username = "htsuser"
            mqttt.password = "hts@123"
            mqttt.willMessage = CocoaMQTTWill(topic: "/will", message: "dieout")
            mqttt.backgroundOnSocket = true
            mqttt.keepAlive = 60
            mqttt.delegate = self
            mqttt.allowUntrustCACertificate = true
            //mqtt.enableSSL = true
            
            let connected = mqttt.connect()
            print("Connected \(connected)")
        
        
      //  mqtt.didReceiveMessage = { mqtt, message, id in
//print("Message received in topic \(message.topic) with payload \(message.string!)")
       // }
     
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate: CocoaMQTTDelegate {
    // Optional ssl CocoaMQTTDelegate
    func mqtt(_ mqtt: CocoaMQTT, didReceive trust: SecTrust, completionHandler: @escaping (Bool) -> Void) {
        TRACE("trust: \(trust)")
        
        completionHandler(true)
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        TRACE("ack: \(ack)")
        
        if ack == .accept {
            mqtt.subscribe("#", qos: CocoaMQTTQOS.qos1)
        }
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didStateChangeTo state: CocoaMQTTConnState) {
        TRACE("new state: \(state)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        TRACE("message: \(String(describing: message.string?.description)), id: \(id)")
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        TRACE("id: \(id)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16 ) {
        TRACE("message: \(String(describing: message.string?.description)), id: \(id)")
        
        
        mqttMsg = message.string?.description
        
        print(mqttMsg!)
        
        
        if mqttMsg != nil {
            // create the alert
            let alert = UIAlertController(title: "Alert", message: "Message recieved \(mqttMsg!)", preferredStyle: UIAlertController.Style.alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            
            // show the alert
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
        } else {
            print("nothing came yet")
        }
        
        
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String) {
        TRACE("topic: \(topic)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
        TRACE("topic: \(topic)")
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        TRACE()
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        TRACE()
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        TRACE("\(err.debugDescription)")
    }
}

extension AppDelegate {
    func TRACE(_ message: String = "", fun: String = #function) {
        let names = fun.components(separatedBy: ":")
        var prettyName: String
        if names.count == 1 {
            prettyName = names[0]
        } else {
            prettyName = names[1]
        }
        
        if fun == "mqttDidDisconnect(_:withError:)" {
            prettyName = "didDisconect"
        }
        
        print("[TRACE] [\(prettyName)]: \(message)")
    }
}
