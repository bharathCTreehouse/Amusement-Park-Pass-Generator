//
//  FoodServiceEmployeePass.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 07/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

class FoodServiceEmployeePass: EmployeePass {
    
    override var areasAccessible: [AreaAccess] {
        var areasPermitted: [AreaAccess] = super.areasAccessible
        areasPermitted.append(.kitchen)
        return areasPermitted
    }
    
}
