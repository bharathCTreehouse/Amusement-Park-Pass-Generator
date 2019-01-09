//
//  VIPPass.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 07/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


class VIPPass: Pass {
   
    override var ridePrivileges: [RideAccess] {
        var priveleges: [RideAccess] = super.ridePrivileges
        priveleges.append(.skipRideLines)
        return priveleges
    }
    
    
    override var discountPrivileges: [Discount] {
        return [Discount.food(10), Discount.merchandise(20)]

    }
}


