//
//  Address.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 07/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

enum AddressError: Swift.Error {
    case missingStreetDetails      //TODO:Handle errors for state and zip code.
    case missingCity
    
    func userDisplayString() -> String {
        
        switch self {
            case .missingStreetDetails: return "Street details can't be blank"
            case .missingCity: return "City can't be blank"
        }
    }
}

struct Address {
    
    var streetAddress: String
    var city: String
    var state: String?
    var zipCode: String?
    
}


extension Address {
    
    func validate() throws {
        
        if streetAddress.isEmpty == true {
            throw AddressError.missingStreetDetails
        }
        else if city.isEmpty == true || city.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines) != nil {
            throw AddressError.missingCity
        }
        
        
    }
}