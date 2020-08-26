//
//  UserAPI.swift
//  Smartlink Cameras
//
//  Created by Roman Haiduk on 26.08.2020.
//  Copyright © 2020 SecureNet Technologies, LLC. All rights reserved.
//


enum UserAPI {

    case login
    case logout
    case getBaseURL(String)
}

extension UserAPI: API {

    var method: HttpMethod {
        switch self {
        case .getBaseURL:
            return .post
        default:
            return .get
        }
    }

    var parameters: [String : Encodable] {
        switch self {
        case let .getBaseURL(name):
            return ["username": name, "method": "getPartnerEnvironment", "environment": enviromet.rawValue]
        default:
            return [:]
        }
    }
}
