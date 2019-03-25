//
//  DisplayableEntrantInformationView.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 19/03/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


class DisplayableEntrantInformationView: UIView {
    
    var entrantImageView: UIImageView? = nil
    var entrantNameLabel: UILabel? = nil
    var passTypeLabel: UILabel? = nil
    var rideLabel: UILabel? = nil
    var foodLabel: UILabel? = nil
    var merchandiseLabel: UILabel? = nil
    
    var displayableDataSource: PersonalInformationDataSource? = nil {
        
        didSet {
            
            //Perform UI updates here.
            setupSubViews()
        }
    }
    
    
    
    init(withDisplayableDataSource dataSource: PersonalInformationDataSource) {
        
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        update(withDisplayableDataSource: dataSource)
    }
    
    
    func update(withDisplayableDataSource dataSource: PersonalInformationDataSource) {
        
        displayableDataSource = dataSource

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    deinit {
        displayableDataSource = nil
        entrantImageView = nil
        entrantNameLabel = nil
        passTypeLabel = nil
        rideLabel = nil
        foodLabel = nil
        merchandiseLabel = nil
    }
}



extension DisplayableEntrantInformationView {
    
    
    func setupSubViews() {
        
        //The entrant image view
        if entrantImageView == nil {
            
            entrantImageView = UIImageView()
            addSubview(entrantImageView!)
            
            entrantImageView!.configure(withConstraints: [.top(referenceConstraint: topAnchor, constantOffSet: 40.0, equalityType: .equalTo),  .width(constantOffSet: 290.0, equalityType: .equalTo),  .height(constantOffSet: 260.0, equalityType: .equalTo),  .centerX(referenceConstraint: centerXAnchor, constantOffSet: -90.0, equalityType: .equalTo)])
            
            entrantImageView!.image = UIImage(named: "FaceImage")
        }
        
        //Entrant name label
        if entrantNameLabel == nil {
            
            entrantNameLabel = UILabel()
            entrantNameLabel!.numberOfLines = 0
            entrantNameLabel!.font = UIFont.boldSystemFont(ofSize: 37.0)
            addSubview(entrantNameLabel!)
            
            entrantNameLabel!.configure(withConstraints: [.top(referenceConstraint: topAnchor, constantOffSet: 40.0, equalityType: .equalTo), .trailing(referenceConstraint: trailingAnchor, constantOffSet: -16.0, equalityType: .equalTo), .leading(referenceConstraint: entrantImageView!.trailingAnchor, constantOffSet: 65.0, equalityType: .equalTo)])
            
        }
        entrantNameLabel!.text = " "
        
        
        for (_, data) in displayableDataSource!.informationCollected.enumerated() {
            
            switch data {
                
                case let .firstName(name): entrantNameLabel!.text = name
                case let .lastName(name): entrantNameLabel!.text = "\(entrantNameLabel!.text ?? "") \(name)"
                default: break
            }
        }
        
        
        //Pass type label
        if passTypeLabel == nil {
            
            passTypeLabel = UILabel()
            passTypeLabel!.numberOfLines = 0
            passTypeLabel!.font = UIFont.boldSystemFont(ofSize: 31.0)
            passTypeLabel!.textColor = UIColor.lightGray
            addSubview(passTypeLabel!)
            
            passTypeLabel!.configure(withConstraints: [.top(referenceConstraint: entrantNameLabel!.bottomAnchor, constantOffSet: 8.0, equalityType: .equalTo),  .trailing(referenceConstraint: trailingAnchor, constantOffSet: -16.0, equalityType: .equalTo),  .leading(referenceConstraint: entrantNameLabel!.leadingAnchor, constantOffSet: 0.0, equalityType: .equalTo)])
        }
        passTypeLabel!.text = displayableDataSource?.passTypeDescription
        
        
        //Ride access label
        if rideLabel == nil {
            
            rideLabel = UILabel()
            rideLabel!.numberOfLines = 0
            rideLabel!.font = UIFont.boldSystemFont(ofSize: 26.0)
            rideLabel!.textColor = UIColor.lightGray
            addSubview(rideLabel!)
            
            rideLabel!.configure(withConstraints: [.top(referenceConstraint: passTypeLabel!.bottomAnchor, constantOffSet: 32.0, equalityType: .equalTo), .trailing(referenceConstraint: trailingAnchor, constantOffSet: -16.0, equalityType: .equalTo), .leading(referenceConstraint: entrantNameLabel!.leadingAnchor, constantOffSet: 0.0, equalityType: .equalTo)])
        }
        rideLabel!.text = "Unlimited rides"
        
        
        //Food discount label
        if foodLabel == nil {
            
            foodLabel = UILabel()
            foodLabel!.numberOfLines = 0
            foodLabel!.font = UIFont.boldSystemFont(ofSize: 26.0)
            foodLabel!.textColor = UIColor.lightGray
            addSubview(foodLabel!)
            
            foodLabel!.configure(withConstraints: [.top(referenceConstraint: rideLabel!.bottomAnchor, constantOffSet: 8.0, equalityType: .equalTo), .trailing(referenceConstraint: trailingAnchor, constantOffSet: -16.0, equalityType: .equalTo), .leading(referenceConstraint: entrantNameLabel!.leadingAnchor, constantOffSet: 0.0, equalityType: .equalTo)])
        }
        foodLabel!.text = "10% Food Discount"
        
        
        //Merchandise discount label
        if merchandiseLabel == nil {
            
            merchandiseLabel = UILabel()
            merchandiseLabel!.numberOfLines = 0
            merchandiseLabel!.font = UIFont.boldSystemFont(ofSize: 26.0)
            merchandiseLabel!.textColor = UIColor.lightGray
            addSubview(merchandiseLabel!)
            
            merchandiseLabel!.configure(withConstraints: [.top(referenceConstraint: foodLabel!.bottomAnchor, constantOffSet: 8.0, equalityType: .equalTo), .trailing(referenceConstraint: trailingAnchor, constantOffSet: -16.0, equalityType: .equalTo), .leading(referenceConstraint: entrantNameLabel!.leadingAnchor, constantOffSet: 0.0, equalityType: .equalTo), .bottom(referenceConstraint: bottomAnchor, constantOffSet: -40.0, equalityType: .equalTo)])
        }
        merchandiseLabel!.text = "20% Merch Discount"
        
        
    }
    
}