//
//  PersonName.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 07/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


struct PersonName {
    
    let firstName: String
    let lastName: String
    
    
    func fullName() -> String {
        return "\(firstName) \(lastName)"
    }
}
