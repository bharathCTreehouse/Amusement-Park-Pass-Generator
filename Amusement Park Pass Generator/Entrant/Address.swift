//
//  Address.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 07/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

enum AddressError: Swift.Error {
    
    case missingStreetDetails
    case missingCity
    case missingState
    case missingZipCode
    case invalidCity
    case invalidState
    case invalidZipCode
    case lengthError_City
    case lengthError_StreetDetails
    case lengthError_State
    case lengthError_ZipCode

    
    func userDisplayString() -> String {
        
        switch self {
            
            case .missingStreetDetails: return "Street details can't be blank"
            case .missingCity: return "City can't be blank"
            case .missingState: return "State can't be blank"
            case .missingZipCode: return "ZipCode can't be blank"
            case .invalidCity: return "City entered is not valid"
            case .lengthError_City: return "City can't be more than 18 characters in length"
            case .lengthError_StreetDetails: return "Street details can't be more than 45 characters in length"
            case .invalidState: return "State entered is not valid"
            case .lengthError_State: return "State can't be more than 20 characters in length"
            case .invalidZipCode: return "ZipCode entered is not valid"
            case .lengthError_ZipCode: return "ZipCode can't be more than 15 characters in length"
            
        }
    }
}

struct Address {
    
    var streetAddress: String
    var city: String
    var state: String
    var zipCode: String
    
    
    mutating func updateStreetAddress(withString address: String) {
        streetAddress = address
    }
    
    mutating func updateCity(withString city: String) {
        self.city = city
    }
    
    mutating func updateState(withString state: String) {
        self.state = state
    }
    
    mutating func updateZipCode(withString zipCode: String) {
        self.zipCode = zipCode
    }
}



extension Address {
    
    func validate() throws {
        
        if streetAddress.isEmpty == true {
            throw AddressError.missingStreetDetails
        }
        else if streetAddress.count > 45 {
            throw AddressError.lengthError_StreetDetails
        }
        
        
        if city.isEmpty == true {
            throw AddressError.missingCity
        }
        else if city.count > 18 {
            throw AddressError.lengthError_City
        }
        else  {
            
            for (_, data) in city.enumerated() {
                
                let str: String? = String(data)
                
                if str!.rangeOfCharacter(from: CharacterSet.lowercaseLetters) == nil && str!.rangeOfCharacter(from: CharacterSet.uppercaseLetters) == nil && str!.rangeOfCharacter(from: CharacterSet.whitespaces) == nil {
                    
                    throw AddressError.invalidCity
                    
                }
            }
            
        }
        
        
        if state.isEmpty == true {
            throw AddressError.missingState
        }
        else if state.count > 20 {
            throw AddressError.lengthError_State
        }
        else {
            
            for (_, data) in state.enumerated() {
                
                let str: String? = String(data)
                
                if str!.rangeOfCharacter(from: CharacterSet.lowercaseLetters) == nil && str!.rangeOfCharacter(from: CharacterSet.uppercaseLetters) == nil && str!.rangeOfCharacter(from: CharacterSet.whitespaces) == nil {
                    
                    throw AddressError.invalidState
                    
                }
            }
        }
        
        
        if  zipCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty == true {
            throw AddressError.missingZipCode
        }
        else if zipCode.count > 15 {
            throw AddressError.lengthError_ZipCode
        }
        else if Int(zipCode) == nil {
            throw AddressError.invalidZipCode
        }
        
    }
}
