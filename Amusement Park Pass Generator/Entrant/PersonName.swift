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
    case invalidLastName
    
    func userDisplayString() -> String {
        
        switch self {
            case .missingFirstName: return "First name can't be blank."
            case .invalidFirstName: return "First name entered is invalid."
            case .invalidLastName: return "Last name entered is invalid."
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
        
        if firstName.isEmpty == true {
            throw PersonNameError.missingFirstName
        }
        else if firstName.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines) != nil || firstName.rangeOfCharacter(from: CharacterSet.symbols) != nil {
            
            throw PersonNameError.invalidFirstName
            
        }
        else {
            //Validate the last name now.
            
            if lastName.isEmpty == false {
                
                //Last name has been entered.
                
                if lastName.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines) != nil || lastName.rangeOfCharacter(from: CharacterSet.symbols) != nil {
                    
                    throw PersonNameError.invalidLastName
                }
            }
        }
        
    }
    
}
