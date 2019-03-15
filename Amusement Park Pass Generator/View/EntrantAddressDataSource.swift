//
//  EntrantAddressDataSource.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 15/03/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


class EntrantAddressDataSource {
    
    private(set) var address: Address? = Address(streetAddress: "", city: "", state: nil, zipCode: nil)
    
    
    func reset() {
        address = nil
    }
    
    
    deinit {
        address = nil
    }
}



extension EntrantAddressDataSource {
    
    
    func updateStreetAddress(withString streetAddress: String) {
        createAddressDataIfRequired()
        address?.updateStreetAddress(withString: streetAddress)
    }
    
    func updateCity(withString city: String) {
        createAddressDataIfRequired()
        address?.updateCity(withString: city)
    }
    
    func updateState(withString state: String) {
        createAddressDataIfRequired()
        address?.updateState(withString: state)
    }
    
    func updateZipCode(withString zipCode: String) {
        createAddressDataIfRequired()
        address?.updateZipCode(withString: zipCode)
    }
    
    
    func createAddressDataIfRequired() {
        
        if address == nil {
            address = Address(streetAddress: "", city: "", state: nil, zipCode: nil)
        }
    }
}
