//
//  MiscEntrantInfoDataSource.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 15/03/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


class MiscEntrantInfoDataSource {
    
    private(set) var dateOfBirth: Date? = nil
    private(set) var project: ProjectRegistered? = nil
    
    
    func reset() {
        dateOfBirth = nil
        project = nil
    }
    
    
    deinit {
        dateOfBirth = nil
        project = nil
    }
}



extension MiscEntrantInfoDataSource {
    
    
    func updateBirthDate(with dob: Date) {
        dateOfBirth = dob
    }
    
    func updateProject(with project: ProjectRegistered) {
        self.project = project
    }
    
}
