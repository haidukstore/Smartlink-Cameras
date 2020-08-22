//
//  String+Localization.swift
//  Smartlink Cameras
//
//  Created by Roman Haiduk on 22.08.2020.
//  Copyright © 2020 SecureNet Technologies, LLC. All rights reserved.
//

import Foundation

func L(_ keyString: String, comment: String = "") -> String{
    NSLocalizedString(keyString, comment: comment)
}
