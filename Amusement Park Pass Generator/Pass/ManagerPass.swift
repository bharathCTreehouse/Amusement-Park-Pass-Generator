//
//  ManagerPass.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 07/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


class ManagerPass: Pass {
    
    override var areasAccessible: [AreaAccess] {
        
        var areasPermitted: [AreaAccess] = super.areasAccessible
        areasPermitted.append(.kitchen)
        areasPermitted.append(.rideControl)
        areasPermitted.append(.maintenance)
        areasPermitted.append(.office)
        return areasPermitted
        
    }
    
    
    override var discountPrivileges: [Discount] {
        return [Discount.food(25), Discount.merchandise(25)]
    }
    
}
