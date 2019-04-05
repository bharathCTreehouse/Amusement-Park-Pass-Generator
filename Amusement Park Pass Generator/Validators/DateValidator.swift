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
    case failedToValidate
}


class DateValidator {
    
    static func validate(date: Date?, forDateType type: TypeOfDate) throws {
        
        
        let currentDate: Date? = Date().formatted(usingFormat: "MM/dd/yyyy")
        let givenDate: Date? = date?.formatted(usingFormat: "MM/dd/yyyy")
        
        
        if currentDate == nil {
            throw DateError.failedToValidate
        }
        if givenDate == nil {
            throw DateError.missingDate
        }
        if givenDate! >= currentDate! {
            throw DateError.invalidDate
        }
        
        let ageCalendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        
        switch type {
            
            
            case let .dateOfBirth(withCriteria: Criteria.under(age: value)):
                
                let compoSet: Set<Calendar.Component> = [Calendar.Component.year]
                let age: Int? = ageCalendar.dateComponents(compoSet, from: givenDate!, to: currentDate!).year
                
                if age != nil {
                    
                    if age! < 0 || age! >= value {
                        throw DateError.invalidDate
                    }
                }
                else {
                    //Could not determine the age.
                    throw DateError.failedToValidate
                }
            
            case let .dateOfBirth(withCriteria: Criteria.above(age: value)):
                
                let compoSet: Set<Calendar.Component> = [Calendar.Component.year, Calendar.Component.month, Calendar.Component.day]
                let age: Int? = ageCalendar.dateComponents(compoSet, from: givenDate!, to: currentDate!).year
                
                if age != nil {
                    
                    if age! < 0 || age! < value {
                        throw DateError.invalidDate
                    }
                    else if age == value {
                        
                        //Get month details.
                        let dateComponent: DateComponents =  ageCalendar.dateComponents(compoSet, from: givenDate!, to: currentDate!)
                        let month: Int? = dateComponent.month
                        if month != nil {
                            if month! < 0 {
                                throw DateError.invalidDate
                            }
                        }
                        else {
                            throw DateError.invalidDate
                        }
                        
                        //Get day details.
                        let day: Int? = dateComponent.day
                        if day != nil {
                            if day! < 0  || (day! == 0 && month! == 0) {
                                throw DateError.invalidDate
                            }
                        }
                        else {
                            throw DateError.invalidDate
                        }
                    }
                }
                else {
                    //Could not determine the age.
                    throw DateError.failedToValidate
                }
        }
    }
    
}
