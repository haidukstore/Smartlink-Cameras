//
//  LoginImage.swift
//  Smartlink Cameras
//
//  Created by Roman Haiduk on 22.08.2020.
//  Copyright © 2020 SecureNet Technologies, LLC. All rights reserved.
//

import UIKit

enum LoginImage: String {
    
    case backgroundImage = "bg_effect"
    case logo = "logo_light"
    
    var image: UIImage {
        ImageType.setImage(name: self.rawValue)
    }
}
