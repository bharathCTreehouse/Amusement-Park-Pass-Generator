//
//  SeasonPass.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 16/03/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


class SeasonPass: Pass {
    
    override var ridePrivileges: [RideAccess] {
        
        var privileges: [RideAccess] = super.ridePrivileges
        privileges.append(.skipRideLines)
        return privileges
        
    }
    
    
    override var discountPrivileges: [Discount] {
        
        return [.food(10), .merchandise(20)]
    }
    
}
