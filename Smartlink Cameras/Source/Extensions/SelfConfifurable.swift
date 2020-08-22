//
//  SelfConfifurable.swift
//  Smartlink Cameras
//
//  Created by Roman Haiduk on 22.08.2020.
//  Copyright © 2020 SecureNet Technologies, LLC. All rights reserved.
//


import Foundation


protocol SelfConfigurable {
    associatedtype Base
    func config(_ closure: (Base) -> Void) -> Base
}

extension SelfConfigurable {
    func config(_ closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }
}

extension NSObject: SelfConfigurable {}

public func configure<T>(_ value: T, using closure: (inout T) throws -> Void) rethrows -> T {
    var value = value
    try closure(&value)
    return value
}
