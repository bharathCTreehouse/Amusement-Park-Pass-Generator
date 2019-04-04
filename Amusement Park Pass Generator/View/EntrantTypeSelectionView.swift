//
//  EntrantTypeSelectionView.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 02/03/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit

protocol EntrantTypeSelectionProtocol: class {
    func didFinishSelectingEntrantType(_ type: EntrantTypeUIIdentifier)
}


class EntrantTypeSelectionView: UIView {
    
    @IBOutlet var entrantTypeSelectionSegment: UISegmentedControl!
    @IBOutlet var entrantSubTypeSelectionSegment: UISegmentedControl!
    
    weak var entrantTypeDelegate: EntrantTypeSelectionProtocol? = nil
    weak var entrantSelectionView: UIView? = nil
    
    
    init(withEntrantTypeSelectionDelegate delegate: EntrantTypeSelectionProtocol) {
        
        entrantTypeDelegate = delegate
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        entrantSelectionView = Bundle.main.loadNibNamed("EntrantTypeSelectionView", owner: self, options: nil)?.first as? UIView
        addSubview(entrantSelectionView!)
        
        entrantSelectionView?.configure(withConstraints: [.leading(referenceConstraint: leadingAnchor, constantOffSet: 0.0, equalityType: .equalTo), .trailing(referenceConstraint: trailingAnchor, constantOffSet: 0.0, equalityType: .equalTo), .top(referenceConstraint: topAnchor, constantOffSet: 0.0, equalityType: .equalTo), .bottom(referenceConstraint: bottomAnchor, constantOffSet: 0.0, equalityType: .equalTo)])
        
        entrantTypeSelectionSegment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 23)], for: .normal)
        entrantSubTypeSelectionSegment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 23)], for: .normal)
        
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @IBAction func entrantTypeSegmentTapped() {
        
        entrantSubTypeSelectionSegment.removeAllSegments()
        
        switch entrantTypeSelectionSegment.selectedSegmentIndex {
            
            case 0:
                entrantSubTypeSelectionSegment.insertSegment(withTitle: "Classic", at: 0, animated: true)
                entrantSubTypeSelectionSegment.insertSegment(withTitle: "VIP", at: 1, animated: true)
                entrantSubTypeSelectionSegment.insertSegment(withTitle: "Child", at: 2, animated: true)
                entrantSubTypeSelectionSegment.insertSegment(withTitle: "Season", at: 3, animated: true)
                entrantSubTypeSelectionSegment.insertSegment(withTitle: "Senior", at: 4, animated: true)
                
                entrantSubTypeSelectionSegment.selectedSegmentIndex = 0
                entrantSubTypeSegmentTapped()
            
            case 1:
            
                entrantSubTypeSelectionSegment.insertSegment(withTitle: "Food services", at: 0, animated: true)
                entrantSubTypeSelectionSegment.insertSegment(withTitle: "Ride services", at: 1, animated: true)
                entrantSubTypeSelectionSegment.insertSegment(withTitle: "Maintenance", at: 2, animated: true)
                entrantSubTypeSelectionSegment.insertSegment(withTitle: "Contract", at: 3, animated: true)
                
                entrantSubTypeSelectionSegment.selectedSegmentIndex = 0
                entrantSubTypeSegmentTapped()
            
            case 2:
                entrantTypeDelegate?.didFinishSelectingEntrantType(.manager)
            
            case 3:
                entrantTypeDelegate?.didFinishSelectingEntrantType(.vendor)



            
            default: break
            
        }
        
    }
    
    
    
    @IBAction func entrantSubTypeSegmentTapped() {
        
        if entrantTypeSelectionSegment.selectedSegmentIndex == 0 {
            
            switch entrantSubTypeSelectionSegment.selectedSegmentIndex {
                
                case 0: entrantTypeDelegate?.didFinishSelectingEntrantType(.classicGuest)
                case 1: entrantTypeDelegate?.didFinishSelectingEntrantType(.vipGuest)
                case 2: entrantTypeDelegate?.didFinishSelectingEntrantType(.childGuest)
                case 3: entrantTypeDelegate?.didFinishSelectingEntrantType(.seasonGuest)
                case 4: entrantTypeDelegate?.didFinishSelectingEntrantType(.seniorGuest)
                default: break
                
            }
            
        }
        else if entrantTypeSelectionSegment.selectedSegmentIndex == 1 {
            
            
            switch entrantSubTypeSelectionSegment.selectedSegmentIndex {
                
                case 0: entrantTypeDelegate?.didFinishSelectingEntrantType(.foodServiceEmployee)
                case 1: entrantTypeDelegate?.didFinishSelectingEntrantType(.rideServiceEmployee)
                case 2: entrantTypeDelegate?.didFinishSelectingEntrantType(.maintenanceEmployee)
                case 3: entrantTypeDelegate?.didFinishSelectingEntrantType(.contractEmployee)
                default: break
                
            }
            
        }

    }

    
}
