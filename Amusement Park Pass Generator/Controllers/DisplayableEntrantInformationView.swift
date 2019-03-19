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
        //backgroundColor = UIColor.yellow
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
        
        //The imageView
        if entrantImageView == nil {
            
            entrantImageView = UIImageView()
            entrantImageView!.translatesAutoresizingMaskIntoConstraints = false
            addSubview(entrantImageView!)
            entrantImageView!.topAnchor.constraint(equalTo: topAnchor, constant: 40.0).isActive = true
            entrantImageView!.widthAnchor.constraint(equalToConstant: 290.0).isActive = true
            entrantImageView!.heightAnchor.constraint(equalToConstant: 260.0).isActive = true
            entrantImageView!.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -90.0).isActive = true
            entrantImageView!.image = UIImage(named: "FaceImage")
        }
        
        if entrantNameLabel == nil {
            
            entrantNameLabel = UILabel()
            entrantNameLabel!.translatesAutoresizingMaskIntoConstraints = false
            entrantNameLabel!.numberOfLines = 0
            entrantNameLabel!.font = UIFont.boldSystemFont(ofSize: 37.0)
            addSubview(entrantNameLabel!)
            entrantNameLabel!.topAnchor.constraint(equalTo: topAnchor, constant: 40.0).isActive = true
            entrantNameLabel!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
            entrantNameLabel!.leadingAnchor.constraint(equalTo: entrantImageView!.trailingAnchor, constant: 65.0).isActive = true
        }
        entrantNameLabel!.text = "Gundu"
        
        
        for (_, data) in displayableDataSource!.informationCollected.enumerated() {
            
            print(data)
            switch data {
                
            case let .firstName(name): entrantNameLabel!.text = name
            case let .lastName(name): entrantNameLabel!.text = "\(entrantNameLabel!.text ?? "") \(name)"
            default: break
            }
        }
        
        
        
        if passTypeLabel == nil {
            
            passTypeLabel = UILabel()
            passTypeLabel!.translatesAutoresizingMaskIntoConstraints = false
            passTypeLabel!.numberOfLines = 0
            passTypeLabel!.font = UIFont.boldSystemFont(ofSize: 31.0)
            passTypeLabel!.textColor = UIColor.lightGray
            addSubview(passTypeLabel!)
            passTypeLabel!.topAnchor.constraint(equalTo: entrantNameLabel!.bottomAnchor, constant: 8.0).isActive = true
            passTypeLabel!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
            passTypeLabel!.leadingAnchor.constraint(equalTo: entrantNameLabel!.leadingAnchor).isActive = true
        }
        passTypeLabel!.text = displayableDataSource?.passTypeDescription
        
        
        
        if rideLabel == nil {
            
            rideLabel = UILabel()
            rideLabel!.translatesAutoresizingMaskIntoConstraints = false
            rideLabel!.numberOfLines = 0
            rideLabel!.font = UIFont.boldSystemFont(ofSize: 26.0)
            rideLabel!.textColor = UIColor.lightGray
            addSubview(rideLabel!)
            rideLabel!.topAnchor.constraint(equalTo: passTypeLabel!.bottomAnchor, constant: 32.0).isActive = true
            rideLabel!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
            rideLabel!.leadingAnchor.constraint(equalTo: entrantNameLabel!.leadingAnchor).isActive = true
        }
        rideLabel!.text = "Unlimited rides"
        
        
        
        if foodLabel == nil {
            
            foodLabel = UILabel()
            foodLabel!.translatesAutoresizingMaskIntoConstraints = false
            foodLabel!.numberOfLines = 0
            foodLabel!.font = UIFont.boldSystemFont(ofSize: 26.0)
            foodLabel!.textColor = UIColor.lightGray
            addSubview(foodLabel!)
            foodLabel!.topAnchor.constraint(equalTo: rideLabel!.bottomAnchor, constant: 8.0).isActive = true
            foodLabel!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
            foodLabel!.leadingAnchor.constraint(equalTo: entrantNameLabel!.leadingAnchor).isActive = true
        }
        foodLabel!.text = "10% Food Discount"
        
        
        
        if merchandiseLabel == nil {
            
            merchandiseLabel = UILabel()
            merchandiseLabel!.translatesAutoresizingMaskIntoConstraints = false
            merchandiseLabel!.numberOfLines = 0
            merchandiseLabel!.font = UIFont.boldSystemFont(ofSize: 26.0)
            merchandiseLabel!.textColor = UIColor.lightGray
            addSubview(merchandiseLabel!)
            merchandiseLabel!.topAnchor.constraint(equalTo: foodLabel!.bottomAnchor, constant: 8.0).isActive = true
            merchandiseLabel!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
            merchandiseLabel!.leadingAnchor.constraint(equalTo: entrantNameLabel!.leadingAnchor).isActive = true
             merchandiseLabel!.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40.0).isActive = true
        }
        merchandiseLabel!.text = "20% Merch Discount"
        
        
    }
    
}
