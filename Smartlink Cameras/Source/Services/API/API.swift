//
//  API.swift
//  Smartlink Cameras
//
//  Created by Roman Haiduk on 26.08.2020.
//  Copyright © 2020 SecureNet Technologies, LLC. All rights reserved.
//


enum Environment: String {
    case production = "PRODUCTION"
    case debug = "DEBUG"
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol API {

    var baseURL: String { get }
    var method: HttpMethod  { get }
    var enviromet: Environment { get }

    var parameters: [String: Encodable] { get}
}

extension API {

    var baseURL: String {
        "http://registration.securenettech.com/registration.php"
    }

    var method: HttpMethod {
        .get
    }

    var enviromet: Environment {
        .production
    }
}
