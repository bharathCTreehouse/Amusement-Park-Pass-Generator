//
//  PersonalInformationDataSource.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 28/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

enum PersonalInfo {
    case firstName(String)
    case lastName(String)
    case streetAddress(String)
    case city(String)
    case state(String)
    case zipCode(String)
}


protocol PersonalInformationDataSource {
    var informationCollected: [PersonalInfo] { get }
    var passTypeDescription: String { get }
}
