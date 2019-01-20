//
//  Wish.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 20/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

enum DateError: Swift.Error {
    case invalidDateOfBirth
    case invalidAnniversaryDate
}

struct Wish {
    
    let birthDate: Date
    let anniversary: Date?
    
    init(withDateOfBirth dob: Date, anniversaryDate annDate: Date? = nil) throws {
        
        if dob > Date() {
            throw DateError.invalidDateOfBirth
        }
        if let annDate = annDate, annDate > Date() {
            throw DateError.invalidAnniversaryDate
        }
        birthDate = dob
        anniversary = annDate
    }
}


extension Wish: EntrantWisher {
    
    var dateOfBirth: Date {
        return birthDate
    }
    
    var anniversaryDate: Date? {
        return anniversary
    }
}
