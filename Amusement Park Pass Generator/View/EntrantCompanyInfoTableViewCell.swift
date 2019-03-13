//
//  EntrantCompanyInfoTableViewCell.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 22/02/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import UIKit
import Foundation


class EntrantCompanyInfoTableViewCell: EntrantInformationTableViewCell {
    
    @IBOutlet private(set) var companyTextField: UITextField!
    @IBOutlet private(set) var dateOfVisitStaticLabel: UILabel!
    @IBOutlet private(set) var dateOfVisitLabel: UILabel!
    
    @IBOutlet private(set) var companyTextFieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet private(set) var dateOfVisitStaticLabelBottomConstraint: NSLayoutConstraint!
    @IBOutlet private(set) var dateOfVisitLabelBottomConstraint: NSLayoutConstraint!



    private var entrantCompany: CompaniesRegistered? = nil {
        
        didSet {
            companyTextField.text = entrantCompany?.displayString
        }
    }


    override func awakeFromNib() {
        
        super.awakeFromNib()
        
       
        companyTextField.delegate = self

        companyTextField.inputView = SelectionPickerView(withPickerList: CompaniesRegistered.orderedDisplayableCompanyList(), completionHandler:
            
            { [unowned self] (selectedIndex: Int)  in
            
                self.companyTextField.delegate = nil
                self.entrantCompany = CompaniesRegistered.orderedCompanyList()[selectedIndex]
                self.endEditing(true)
                self.companyTextField.delegate = self
                
        })
        
    }
    
    
    
    override func resetData() {
        entrantCompany = nil
    }
    
    
    
    override func performAdditionalCustomization() {
        
        if state == .inActive {
            
            dateOfVisitLabelBottomConstraint.isActive = false
            dateOfVisitStaticLabelBottomConstraint.isActive = false
            companyTextFieldBottomConstraint.isActive = true
            
            dateOfVisitStaticLabel.isHidden = true
            dateOfVisitLabel.isHidden = true
        }
        else if state == .active {
            
            dateOfVisitLabelBottomConstraint.isActive = true
            dateOfVisitStaticLabelBottomConstraint.isActive = true
            companyTextFieldBottomConstraint.isActive = false
            
            dateOfVisitStaticLabel.isHidden = false
            dateOfVisitLabel.isHidden = false
            
            
            //Set current date
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            dateOfVisitLabel.text = dateFormatter.string(from: Date())
        }
        
    }
    
    
    
    deinit {
        entrantCompany = nil
        companyTextField = nil
        dateOfVisitStaticLabel = nil
        dateOfVisitLabel = nil
        companyTextFieldBottomConstraint = nil
        dateOfVisitStaticLabelBottomConstraint = nil
        dateOfVisitLabelBottomConstraint = nil
    }

}



extension EntrantCompanyInfoTableViewCell: UITextFieldDelegate {
    
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        let selectionView: SelectionPickerView? = (companyTextField?.inputView) as? SelectionPickerView
        
        if let selectionView = selectionView {
            selectionView.closeSelectionPickerView()
        }
        
    }
    
}
