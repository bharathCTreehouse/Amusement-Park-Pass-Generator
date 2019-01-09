//
//  RideAccessDataSource.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 07/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

enum RideAccess {
    case all
    case skipRideLines
    case undefined
}

protocol RideAccessDataSource  {
    var ridePrivileges: [RideAccess] { get }
}
