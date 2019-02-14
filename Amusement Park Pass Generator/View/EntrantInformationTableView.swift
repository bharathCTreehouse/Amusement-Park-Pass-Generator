//
//  EntrantInformationTableView.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 13/02/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


class EntrantInformationTableView: UITableView {
    
    init(withTableViewStyle style: Style) {
        
        super.init(frame: .zero, style: style)
        dataSource = self
        register(UINib.init(nibName: "EntrantNameTableViewCell", bundle: .main), forCellReuseIdentifier: "entrantNameCell")
        register(UINib.init(nibName: "EntrantAddressTableViewCell", bundle: .main), forCellReuseIdentifier: "entrantAddressCell")

        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 44.0
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}



extension EntrantInformationTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        else {
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "entrantNameCell", for: indexPath)
            return cell
        }
        else {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "entrantAddressCell", for: indexPath)
            return cell
        }
        
    }
    
    
}
