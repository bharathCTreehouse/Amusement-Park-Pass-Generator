//
//  AccessKioskTableView.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 17/03/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


class AccessKioskTableView: UITableView {
    
    var accessTestingCompletionHandler: ((Int) -> Void)? = nil
    var displayableDataSource: PersonalInformationDataSource? = nil
    
    
    init(withAccessTestingCompletionHandler handler: @escaping ((Int) -> Void), displayableDataSource: PersonalInformationDataSource ) {
        
        accessTestingCompletionHandler = handler
        self.displayableDataSource = displayableDataSource
        super.init(frame: .zero, style: .grouped)
        register(UINib.init(nibName: "AccessTestingTableViewCell", bundle: .main), forCellReuseIdentifier: "accessTestingCell")
        register(DisplayableEntrantInfoTableViewCell.classForCoder(), forCellReuseIdentifier: "passInfoCell")
        translatesAutoresizingMaskIntoConstraints = false
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 44.0
        dataSource = self
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    deinit {
        accessTestingCompletionHandler = nil
        displayableDataSource = nil
    }
    
}



extension AccessKioskTableView: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell: DisplayableEntrantInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "passInfoCell", for: indexPath) as! DisplayableEntrantInfoTableViewCell
            cell.update(withDisplayableDataSource: displayableDataSource!)
            return cell
            
        }
        else {
            let cell: AccessTestingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "accessTestingCell", for: indexPath) as! AccessTestingTableViewCell
            return cell
        }
        
    }
    
    
}
