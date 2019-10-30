//
//  AppConstant.swift
//  lab_mmt
//
//  Created by Imbaggaarm on 10/27/19.
//  Copyright © 2019 Tai Duong. All rights reserved.
//

import UIKit

class AppConstant {
    static let myScreenType = UIDevice.current.screenType
    static let butBorderWidth: CGFloat = 1.5
    
    static let heightOfLoginButton: CGFloat = 40
}

struct K {
    struct ProductionServer {
        static let baseURL = "https://362e9e63.ngrok.io/api/v1"
    }
    
    struct APIParameterKey {
        static let password = "password"
        static let email = "email"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
    case form_urlencoded = "application/x-www-form-urlencoded"
}