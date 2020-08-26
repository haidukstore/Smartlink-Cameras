//
//  UserBaseURL.swift
//  Smartlink Cameras
//
//  Created by Roman Haiduk on 26.08.2020.
//  Copyright © 2020 SecureNet Technologies, LLC. All rights reserved.
//

import Foundation


class UserBaseURL: Decodable {

    let baseURL: String

    required init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: RootCodingKeys.self)

        let platfrom = try container.nestedContainer(keyedBy: PlatformCodingKeys.self, forKey: .platform)
        self.baseURL = try platfrom.decodeIfPresent(String.self, forKey: .baseURL) ?? ""
    }
}


extension UserBaseURL {

    enum RootCodingKeys:String, CodingKey {

        case platform
        case server
    }

    enum PlatformCodingKeys:String, CodingKey {

        case baseURL
    }
}
