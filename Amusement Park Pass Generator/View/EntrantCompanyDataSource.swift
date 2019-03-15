//
//  EntrantCompanyDataSource.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 15/03/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


class EntrantCompanyDataSource {
    
    private(set) var company: CompaniesRegistered? = nil
    private(set) var dateOfVisit: Date? = nil
    
    
    func reset() {
        company = nil
        dateOfVisit = nil
    }
    
    
    deinit {
        company = nil
        dateOfVisit = nil
    }
}


extension EntrantCompanyDataSource {
    
    func updateCompany(with company: CompaniesRegistered) {
        self.company = company
    }
    
    
    func updateDateOfVisit(with date: Date) {
        dateOfVisit = date
    }
}
