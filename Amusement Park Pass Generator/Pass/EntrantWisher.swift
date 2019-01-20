//
//  EntrantWisher.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 20/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


protocol EntrantWisher {
    
    var dateOfBirth: Date { get }
    var anniversaryDate: Date? { get }
    
}

extension EntrantWisher {
    
    var anniversaryDate: Date? {
        return nil
    }

}
