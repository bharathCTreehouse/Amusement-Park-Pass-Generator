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
            
            displayableEntrantInfoView!.configure(withConstraints: [.leading(referenceConstraint: contentView.leadingAnchor, constantOffSet: 16.0, equalityType: .equalTo), .trailing(referenceConstraint: contentView.trailingAnchor, constantOffSet: -16.0, equalityType: .equalTo), .top(referenceConstraint: contentView.topAnchor, constantOffSet: 16.0, equalityType: .equalTo), .bottom(referenceConstraint: contentView.bottomAnchor, constantOffSet: -30.0, equalityType: .equalTo)])
            
        }
        else {
            displayableEntrantInfoView!.update(withDisplayableDataSource: dataSource)
        }
    }
    
    
    deinit {
        displayableEntrantInfoView = nil
    }

}
