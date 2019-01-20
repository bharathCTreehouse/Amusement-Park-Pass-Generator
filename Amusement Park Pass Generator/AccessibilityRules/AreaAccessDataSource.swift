//
//  AreaAccessDataSource.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 07/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


enum AreaAccess {
    case amusement
    case kitchen
    case rideControl
    case maintenance
    case office
    case undefined
}


protocol AreaAccessDataSource {
    var areasAccessible: [AreaAccess] { get }
}


extension AreaAccessDataSource {
    
    var isValid: Bool {
        return !areasAccessible.isEmpty
    }
}
