//
//  DisplayableEntrantInfoTableViewCell.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 19/03/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import UIKit

class DisplayableEntrantInfoTableViewCell: UITableViewCell {

    var displayableEntrantInfoView: DisplayableEntrantInformationView? = nil
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    func update(withDisplayableDataSource dataSource: PersonalInformationDataSource) {
        
        if displayableEntrantInfoView == nil {
            
            displayableEntrantInfoView = DisplayableEntrantInformationView(withDisplayableDataSource: dataSource)
            contentView.addSubview(displayableEntrantInfoView!)
            displayableEntrantInfoView!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
            displayableEntrantInfoView!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0).isActive = true
            displayableEntrantInfoView!.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0).isActive = true
            displayableEntrantInfoView!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30.0).isActive = true
            
        }
        else {
            displayableEntrantInfoView!.update(withDisplayableDataSource: dataSource)
        }
    }
    
    
    deinit {
        displayableEntrantInfoView = nil
    }

}
