//
//  StringUtilities.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 07/04/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


extension CustomStringConvertible {
    
    func containsOnlyEmptySpaces() -> Bool {
        return self.description.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
    
    
    func containsOnlyAlphabets() -> Bool {
        
        for (_, data) in self.description.enumerated() {
            
            let str: String = String(data)
            if str.rangeOfCharacter(from: CharacterSet.letters) == nil {
                return false
            }
        }
        return true
        
        /*This can also be done using the filter method*/
       /*let alphabetsArray =  self.description.filter({ (ch: Character) -> Bool in
            
            let str: String = String(ch)
            if str.rangeOfCharacter(from: CharacterSet.letters) == nil {
                return false
            }
            return true

        })
        return alphabetsArray.count == self.description.count*/
    }
    
    
    func containsCharactersOtherThanAlphabetsAndWhiteSpaces() -> Bool {
        
        for (_, data) in self.description.enumerated() {
            
            let str: String = String(data)
            if str.rangeOfCharacter(from: CharacterSet.letters) == nil && str.rangeOfCharacter(from: CharacterSet.whitespaces) == nil {
                return true
            }
        }
        
        return false
        
    }
    
    
    func containsOnlyNumbers() -> Bool {
        
        guard let _ = Int(self.description) else  {
            return false
        }
        return true
    }
    
}
