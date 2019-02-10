//
//  MaintenanceEmployeePass.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 07/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


class MaintenanceEmployeePass: EmployeePass {
    
    override var areasAccessible: [AreaAccess] {
        var areasPermitted: [AreaAccess] = super.areasAccessible
        areasPermitted.append(contentsOf: [.kitchen, .rideControl, .maintenance])
        return areasPermitted
    }
    
}
