//
//  Config.swift
//  lab_mmt
//
//  Created by Imbaggaarm on 10/27/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import Foundation

// Set this to the machine's address which runs the signaling server
fileprivate let defaultServerUrlStr = "362e9e63.ngrok.io/api/v1"
fileprivate let defaultSignalingServerUrl = URL(string: "ws://\(defaultServerUrlStr)/ws")!
fileprivate let defaultRestServerUrl = URL(string:"https://\(defaultServerUrlStr)")!

// We use Google's public stun servers. For production apps you should deploy your own stun/turn servers.
fileprivate let defaultIceServers = ["stun:stun.l.google.com:19302",
                                     "stun:stun1.l.google.com:19302",
                                     "stun:stun2.l.google.com:19302",
                                     "stun:stun3.l.google.com:19302",
                                     "stun:stun4.l.google.com:19302"]

struct Config {
    let signalingServerUrl: URL
    let restServerUrl: URL
    let webRTCIceServers: [String]
    
    static let `default` = Config(signalingServerUrl: defaultSignalingServerUrl, restServerUrl: defaultRestServerUrl, webRTCIceServers: defaultIceServers)
}