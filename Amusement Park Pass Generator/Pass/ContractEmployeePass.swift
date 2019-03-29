//
//  ContractEmployeePass.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 14/03/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

enum ProjectRegistered {
    
    case project_1001
    case project_1002
    case project_1003
    case project_2001
    case project_2002
    
    var displayString: String {
        
        switch self {
            case .project_1001: return "1001"
            case .project_1002: return "1002"
            case .project_1003: return "1003"
            case .project_2001: return "2001"
            case .project_2002: return "2002"

            
        }
    }
    
    
    static func orderedDisplayableProjectList() -> [String] {
        return ["1001", "1002", "1003", "2001", "2002"]
    }
    
    
    static func orderedProjectList() -> [ProjectRegistered] {
        return [.project_1001, project_1002, project_1003, project_2001, project_2002]
    }
    
    
    func areasPermittedToAccess() -> [AreaAccess] {
        
        switch self {
            case .project_1001: return [.amusement, .rideControl]
            case .project_1002: return [.amusement, .rideControl, .maintenance]
            case .project_1003: return [.amusement, .rideControl, .kitchen, .maintenance, .office]
            case .project_2001: return [.office]
            case .project_2002: return [.kitchen, .maintenance]
        }
        
    }
}



class ContractEmployeePass: EmployeePass {
    
    override var discountPrivileges: [Discount] {
        return [.none]
    }
    
    override var areasAccessible: [AreaAccess] {
        
        if let project = self.entrant.type.projectEntrantIsWorkingOn() {
            return project.areasPermittedToAccess()
        }
        else {
            return super.areasAccessible
        }
    }
    
    
    override var ridePrivileges: [RideAccess] {
        return [.undefined]
    }
    
}
