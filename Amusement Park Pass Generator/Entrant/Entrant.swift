//
//  Entrant.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 07/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

//Should we have an unknown type here??
enum EntrantType {
    case guest (GuestType)
    case employee (EmployeeType)
    case manager (PersonName, Address)
}


enum GuestType {
    case classic
    case vip
    case freeChild (Date)
}


enum EmployeeType  {
    case foodServices (PersonName, Address)
    case rideServices (PersonName, Address)
    case maintenance (PersonName, Address)
}


class Entrant {
    
    var type: EntrantType
    var entrantNumber: Int = 0
    var pass: (AreaAccessDataSource & RideAccessDataSource & DiscountAccessDataSource)
    
    
    init(withPass pass: Pass, entrantType: EntrantType, entrantNumber: Int) {
        
        self.entrantNumber = entrantNumber
        type = entrantType
        self.pass = pass
    }
}
