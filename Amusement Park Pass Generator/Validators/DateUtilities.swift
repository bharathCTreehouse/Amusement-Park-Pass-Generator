//
//  DateUtilities.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 01/04/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation



extension Date {
    
    func string(withDateFormat format: String) -> String? {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    
    func formatted(usingFormat format: String) -> Date? {
        
        let dateString: String? = self.string(withDateFormat: format)
        return (dateString?.date(withFormat: format))
    }
    
}



extension String {
    
    
    func date(withFormat format: String) -> Date? {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from:self)
    }
    
}
