//
//  Pass.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 07/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


class Pass: AccessDataSource {
    
    var passNumber: PassIdentifier = 0
    
    let entrant: Entrant
    
    
    init(withPassNumber passNumber: PassIdentifier, entrant: Entrant) {
        
        self.passNumber = passNumber
        self.entrant = entrant
    }
    
    
    //MARK: AreaAccessDataSource
    var areasAccessible: [AreaAccess] {
        return [.amusement]
    }
    
    //MARK: RideAccessDataSource
    var ridePrivileges: [RideAccess] {
        return [.all]
    }
    
    //MARK: DiscountAccessDataSource
    var discountPrivileges: [Discount] {
        return [.none]
    }
    
    
    //MARK: AccessDataSource
    var uniqueIdentifier: PassIdentifier {
        return passNumber
    }
}



extension Pass: PersonalInformationDataSource {
    
    /*Information collected here will be used to display on the pass*/
    
    var informationCollected: [PersonalInfo] {
        
        var data: [PersonalInfo] = []
        
        if let nameDetails = self.entrant.type.nameOfEntrant() {
            
            data.append(PersonalInfo.firstName(nameDetails.firstName))
            data.append(PersonalInfo.lastName(nameDetails.lastName))
        }
        if let address = self.entrant.type.addressOfEntrant() {
            
            if let state = address.state {
                data.append(PersonalInfo.state(state))
            }
            if let zipCode = address.zipCode {
                data.append(PersonalInfo.state(zipCode))
            }
            data.append(PersonalInfo.state(address.streetAddress))
            data.append(PersonalInfo.state(address.city))
            
        }
        return data
    }
    
    
    /*Information collected here will be used to display on the pass*/

    var passTypeDescription: String {
        return self.entrant.type.passTypeString()
    }

}
