//
//  RideAccessDataSource.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 07/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

enum RideAccess {
    
    case all
    case skipRideLines
    
    func rideAccessString() -> String {
        
        switch self {
            case .all: return "You have access to all rides"
            case .skipRideLines: return "You can skip lines"
        }
    }
}

protocol RideAccessDataSource  {
    var ridePrivileges: [RideAccess] { get }
}
