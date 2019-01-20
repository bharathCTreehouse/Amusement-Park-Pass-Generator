//
//  EntrantInformationDisplayable.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 20/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

protocol EntrantInformationDisplayable {
    var entrantDescription: String { get }
    var fullName: String? { get }
}


/*protocol NameDisplayable: EntrantDisplayable {
    var fullName: String { get }
}


extension EntrantDisplayable {
    var entrantDescription: String {
        return "pass"
    }
}

extension NameDisplayable {
    var fullName: String {
        return "XXX"
    }
}*/
