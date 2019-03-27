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
import UserNotifications

var mqttMsg: String? = ""
var mqttt: CocoaMQTT!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    let notificationDelegate = QRCodeNotificationDelegate()

  
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
           registerForPushNotifications()

        UIApplication.shared.statusBarStyle = .lightContent

        if Reachability.isConnectedToNetwork() {
            
            print("Connected to Network")
            
        } else {
            
            let alertController = UIAlertController (title: "Attention!!", message: "You are offline Please turn on internet.", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindow.Level.alert + 1
            alertWindow.makeKeyAndVisible()
            
            alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)

            
        }
        
        let lastURL = UserDefaults.standard.url(forKey: "MyApp.lastURL")
        
        if lastURL != nil {
            print("Items Prints")
            
            UserDefaults.standard.string(forKey: "Key")
            
            if let rootViewController = self.window!.rootViewController as? UINavigationController {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                if let viewcontroller = storyboard.instantiateViewController(withIdentifier: "Maps") as? MapDetailsViewController {
                    rootViewController.pushViewController(viewcontroller, animated: true)
                }
            }
            
        } else {
            
            if let rootViewController = self.window!.rootViewController as? UINavigationController {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                if let viewcontroller = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                    rootViewController.pushViewController(viewcontroller, animated: true)
                }
            }
            
        }
        
        
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



extension AppDelegate{
    
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            // 1. Check if permission granted
            guard granted else { return }
            // 2. Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    
    //MARK: Delegate methods for notifications
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("APNs device token: \(deviceTokenString)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("APNs registration failed: \(error)")
    }
    
    
    //MARK: Notification Configuration
    
    func configureNotification() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            center.delegate = notificationDelegate
            let openAction = UNNotificationAction(identifier: "OpenNotification", title: NSLocalizedString("Abrir", comment: ""), options: UNNotificationActionOptions.foreground)
            let deafultCategory = UNNotificationCategory(identifier: "CustomSamplePush", actions: [openAction], intentIdentifiers: [], options: [])
            center.setNotificationCategories(Set([deafultCategory]))
        } else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    
}

