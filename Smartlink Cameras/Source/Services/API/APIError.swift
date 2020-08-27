//
//  APIError.swift
//  Smartlink Cameras
//
//  Created by Roman Haiduk on 26.08.2020.
//  Copyright © 2020 SecureNet Technologies, LLC. All rights reserved.
//
import Foundation

enum APIError: Error, CustomStringConvertible {

    case invalidResponse
    case invalidData
    case domainError(String)
    case serverError(String)


    var description: String {

        switch self {
        case let .serverError(errorDescription), let .domainError(errorDescription):
            return errorDescription
        case .invalidData:
            return L("Invalid Request Data")
        case .invalidResponse:
            return L("Invalid Response")
        }
    }
}
