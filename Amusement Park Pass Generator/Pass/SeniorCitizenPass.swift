//
//  SeniorCitizenPass.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 30/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

class SeniorCitizenPass: ReminderPass {
    
    override var ridePrivileges: [RideAccess] {
        var rides: [RideAccess] = super.ridePrivileges
        rides.append(.skipRideLines)
        return rides
    }
    
    
    override var discountPrivileges: [Discount] {
        return [Discount.food(10), Discount.merchandise(10)]
    }
}



