//
//  NotificationsViewController.swift
//  QRCodeDemo
//
//  Created by HyperThink Systems on 13/03/19.
//  Copyright © 2019 HyperThink Systems. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {

    var popoverVC: UIPopoverController!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func closeButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)

    }
    

}
