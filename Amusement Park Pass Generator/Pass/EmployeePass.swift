//
//  EmployeePass.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 07/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


class EmployeePass: Pass {
    
    override var discountPrivileges: [Discount] {
        return [Discount.food(15), Discount.merchandise(25)]
    }
}
