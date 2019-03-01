//
//  EntrantTypeSelectionView.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 02/03/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit

class EntrantTypeSelectionView: UIView {
    
    @IBOutlet var entrantTypeSelectionSegment: UISegmentedControl!
    @IBOutlet var entrantSubTypeSelectionSegment: UISegmentedControl!
    
    
    override func awakeFromNib() {
        
        entrantTypeSelectionSegment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 21)], for: .normal)
        entrantSubTypeSelectionSegment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 21)], for: .normal)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @IBAction func entrantTypeSegmentTapped() {
        
        print("entrantTypeSegmentTapped")
        if entrantTypeSelectionSegment.selectedSegmentIndex == 3 {
            
            UIView.animate(withDuration: 1.5, delay: 0.0, options: .curveEaseOut, animations: {
                self.entrantSubTypeSelectionSegment.isHidden = true

            }, completion: nil)
        }
        else {
            UIView.animate(withDuration: 1.5, delay: 0.0, options: .curveEaseIn, animations: {
                self.entrantSubTypeSelectionSegment.isHidden = false
                
            }, completion: nil)
        }
    }
    
    
    
    @IBAction func entrantSubTypeSegmentTapped() {
        print("entrantSubTypeSegmentTapped")

    }

    
}
