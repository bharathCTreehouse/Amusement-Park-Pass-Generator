//
//  PersonName.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 07/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

enum PersonNameError: Swift.Error {
    
    case missingFirstName
    case invalidFirstName
    case missingLastName
    case invalidLastName
    case lengthError
    
    func userDisplayString() -> String {
        
        switch self {
            case .missingFirstName: return "First name can't be blank"
            case .invalidFirstName: return "First name entered is invalid"
            case .missingLastName: return "Last name can't be blank"
            case .invalidLastName: return "Last name entered is invalid"
            case .lengthError: return "The first/last name can't be more than 35 characters in length"
        }
    }
}


struct PersonName {
    
    var firstName: String
    var lastName: String
    
    
    func fullName() -> String {
        return "\(firstName) \(lastName)"
    }
    
    mutating func updateFirstName(withString fName: String) {
        firstName = fName
    }
    
    mutating func updateLastName(withString lName: String) {
        lastName = lName
    }
}



extension PersonName {
    
    func validate() throws {
        
        if let firstNameError = errorInFirstName() {
            throw firstNameError
        }
        
        if let lastNameError = errorInLastName() {
            throw lastNameError
        }
        
    }
    
    
    func errorInFirstName() -> PersonNameError? {
        
        if firstName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty == true {
            return PersonNameError.missingFirstName
        }
        else if firstName.count > 35 {
            return PersonNameError.lengthError
        }
        else  {
            
            for (_, data) in firstName.enumerated() {
                
                let str: String? = String(data)
                
                if str!.rangeOfCharacter(from: CharacterSet.lowercaseLetters) == nil && str!.rangeOfCharacter(from: CharacterSet.uppercaseLetters) == nil {
                    
                    return PersonNameError.invalidFirstName
                    
                }
            }
            
        }
        
        return nil
    }
    
    
    func errorInLastName() -> PersonNameError? {
        
        if lastName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty == true {
            return PersonNameError.missingLastName
        }
        else if lastName.count > 35 {
            return PersonNameError.lengthError
        }
        else  {
            
            for (_, data) in lastName.enumerated() {
                
                let str: String? = String(data)
                
                if str!.rangeOfCharacter(from: CharacterSet.lowercaseLetters) == nil && str!.rangeOfCharacter(from: CharacterSet.uppercaseLetters) == nil && str!.rangeOfCharacter(from: CharacterSet.whitespaces) == nil {
                    
                    return PersonNameError.invalidLastName
                    
                }
            }
            
        }
        return nil
        
    }
    
}
