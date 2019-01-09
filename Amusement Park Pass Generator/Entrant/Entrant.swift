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
    case manager
}


enum GuestType {
    case classic
    case vip
    case freeChild
}


enum EmployeeType {
    case foodServices
    case rideServices
    case maintenance
}


class Entrant {
    
    var name: PersonName?
    var address: Address?
    var dateOfBirth: Date? = nil
    var type: EntrantType
    var entrantNumber: Int = 0
    var pass: (AreaAccessDataSource & RideAccessDataSource & DiscountAccessDataSource)? = nil
    
    
    init(withName name: PersonName?, address: Address?, entrantType: EntrantType, entrantNumber: Int) {
        
        self.name = name
        self.address = address
        self.entrantNumber = entrantNumber
        type = entrantType
    }
    
    
    convenience init(withDateOfBirth date: Date, entrantType: EntrantType, entrantNumber: Int) {
        
        self.init(withName: nil, address: nil, entrantType: entrantType, entrantNumber: entrantNumber)
        dateOfBirth = date
    }
    
    
    convenience init(withEntrantType type: EntrantType, entrantNumber: Int) {
        self.init(withName: nil, address: nil, entrantType: type, entrantNumber: entrantNumber)
    }
    
    
    
    deinit {
        name = nil
        address = nil
        dateOfBirth = nil
    }
   
    
}
