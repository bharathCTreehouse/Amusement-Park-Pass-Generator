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
    case none
    case undefined
    
    /*static func == (lhs: Discount, rhs: Discount) -> Bool {
        
        var detailTuple: (Discount,Int)
        
        switch lhs {
            case let .food(v1): detailTuple = (Discount.food(v1), v1)
            case .undefined: detailTuple = (Discount.undefined, 0)
            case .none: print("None")
            case let .merchandise(m1): print(m1)
        }
            
        
        return true
    }*/
    
    

}


protocol DiscountAccessDataSource {
    var discountPrivileges: [Discount] { get }
}



