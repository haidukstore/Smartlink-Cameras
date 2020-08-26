//
//  APIError.swift
//  Smartlink Cameras
//
//  Created by Roman Haiduk on 26.08.2020.
//  Copyright © 2020 SecureNet Technologies, LLC. All rights reserved.
//

enum APIError: Error {

    case invalidResponse
    case invalidData
    case timeout
    case noInternetConnection
}
