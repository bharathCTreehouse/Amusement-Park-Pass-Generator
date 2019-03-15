//
//  EntrantNameDataSource.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 15/03/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


class EntrantNameDataSource {
    
    private(set) var entrantName: PersonName? = PersonName(firstName: "", lastName: "")
    
    
    func reset() {
        entrantName = nil
    }
    
    
    deinit {
        entrantName = nil
    }
}



extension EntrantNameDataSource {
    
    
    func updateFirstName(with firstName: String) {
        createPersonDataIfRequired()
        entrantName?.updateFirstName(withString: firstName)
    }
    
    
    func updateLastName(with lastName: String) {
        createPersonDataIfRequired()
        entrantName?.updateLastName(withString: lastName)
    }
    
    
    
    private func createPersonDataIfRequired() {
        
        if entrantName == nil {
            entrantName = PersonName(firstName: "", lastName: "")
        }
    }
    
}
