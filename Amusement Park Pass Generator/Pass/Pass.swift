//
//  Pass.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 07/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

class Pass: AreaAccessDataSource, RideAccessDataSource, DiscountAccessDataSource {
    
    var passNumber: Int = 0  //Pass number should be assigned with entrant number.
    
    init(withPassNumber passIdentifier: Int) {
        passNumber = passIdentifier
    }
    
    
    var areasAccessible: [AreaAccess] {
        return [.amusement]
    }
    
    var ridePrivileges: [RideAccess] {
        return [.all]
    }
    
    var discountPrivileges: [Discount] {
        return [.none]
    }
}

