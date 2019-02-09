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
    
    func areaAccessString() -> String {
        
        switch self {
            case .amusement: return "You have access to amusement area"
            case .kitchen: return "You have access to kitchen area"
            case .rideControl: return "You have access to ride control areas"
            case .maintenance: return "You have access to maintenance area"
            case .office: return "You have access to office area"


            default:
                return "You have no access"
        }
    }
}


protocol AreaAccessDataSource {
    var areasAccessible: [AreaAccess] { get }
}




/*extension AreaAccessDataSource {
    
    var isValid: Bool {
        return !areasAccessible.isEmpty || !areasAccessible.contains(.undefined)
    }
}*/
