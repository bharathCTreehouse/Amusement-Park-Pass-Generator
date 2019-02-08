//
//  DateValidator.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 03/02/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

enum TypeOfDate {
    case dateOfBirth(withCriteria: Criteria)
}

enum Criteria {
    case under(age: Int)
    case above(age: Int)
}

enum DateError: Swift.Error {
    case invalidDate
    case missingDate
}


class DateValidator {
    
    static func validate(date: Date?, forDateType type: TypeOfDate) throws {
        
        guard let _ = date else {
            //When no date is entered.
            throw DateError.missingDate
        }
        
        
       let currentDate: Date = Date()

        
        switch type {
            
            
            case let .dateOfBirth(withCriteria: Criteria.under(age: value)):
                    let numberOfDays: Double = 365 * Double(value)
                    let numberOfSeconds: Double = numberOfDays * 86400
                    if currentDate.timeIntervalSince(date!) > numberOfSeconds ||  date! > currentDate {
                        throw DateError.invalidDate
                    }
            case let .dateOfBirth(withCriteria: Criteria.above(age: value)):
                    let numberOfDays: Double = 365 * Double(value)
                    let numberOfSeconds: Double = numberOfDays * 86400
                    if currentDate.timeIntervalSince(date!) < numberOfSeconds ||  date! > currentDate{
                        throw DateError.invalidDate
                    }
            }
        
    }
    
}
