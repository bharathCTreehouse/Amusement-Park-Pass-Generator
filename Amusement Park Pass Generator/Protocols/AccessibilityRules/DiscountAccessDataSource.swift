//
//  DiscountAccessDataSource.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 07/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


enum Discount {
    
    case food (Int)
    case merchandise (Int)
    
    func discountString() -> String {
        
        switch self {
            case let .food(value): return "\(value) % discount on food"
            case let .merchandise(value): return "\(value) % discount on merchandise"
        }
    }
    
}


protocol DiscountAccessDataSource {
    var discountPrivileges: [Discount] { get }
}



