//
//  APIService.swift
//  Smartlink Cameras
//
//  Created by SecureNet Mobile Team on 1/10/20.
//  Copyright © 2020 SecureNet Technologies, LLC. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {
    // Just an example
    func request(with name: String) -> Decodable
}

final class APIService: APIServiceProtocol {
    
    
    init() {
        
    }
    
    func request(with name: String) -> Decodable {
        
    }
    
    deinit {
        
    }
    
}
