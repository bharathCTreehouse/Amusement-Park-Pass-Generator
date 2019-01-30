//
//  AccessDataSource.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 31/01/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


protocol AccessDataSource: AreaAccessDataSource, RideAccessDataSource, DiscountAccessDataSource {
    
}
