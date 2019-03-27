//
//  APIModel.swift
//  QRCodeDemo
//
//  Created by HyperThink Systems on 26/03/19.
//  Copyright © 2019 HyperThink Systems. All rights reserved.
//

import Foundation

struct Lol: Codable {
    let device, siteName, deviceName, solution: String
    let deviceID, deviceType: String
    let latitude, longitude: Int
    let gateway, gatewayID: String
    
    enum CodingKeys: String, CodingKey {
        case device, siteName, deviceName, solution
        case deviceID = "deviceId"
        case deviceType, latitude, longitude, gateway
        case gatewayID = "gatewayId"
    }
}
