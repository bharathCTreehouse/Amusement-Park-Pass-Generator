//
//  RideServiceEmployeePass.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 07/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

class RideServiceEmployeePass: EmployeePass {
    
    override var areasAccessible: [AreaAccess] {
        var areasPermitted: [AreaAccess] = super.areasAccessible
        areasPermitted.append(.rideControl)
        return areasPermitted
    }
    
}
