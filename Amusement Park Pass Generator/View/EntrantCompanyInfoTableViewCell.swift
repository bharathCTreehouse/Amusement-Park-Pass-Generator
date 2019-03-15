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
    
    
    private(set) var entrantCompanyDataSource: EntrantCompanyDataSource? = nil {
        
        didSet {
            companyTextField.text = entrantCompanyDataSource?.company?.displayString
        }
    }


    
    func updateDataSource(with dataSource: EntrantCompanyDataSource) {
        entrantCompanyDataSource = dataSource
    }


    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
       
        companyTextField.delegate = self

        companyTextField.inputView = SelectionPickerView(withPickerList: CompaniesRegistered.orderedDisplayableCompanyList(), completionHandler:
            
            { [unowned self] (selectedIndex: Int)  in
            
                self.companyTextField.delegate = nil
                let companySelected: CompaniesRegistered = CompaniesRegistered.orderedCompanyList()[selectedIndex]
                self.entrantCompanyDataSource?.updateCompany(with: companySelected)
                self.updateDataSource(with: self.entrantCompanyDataSource!)
                self.endEditing(true)
                self.companyTextField.delegate = self
                
        })
        
    }
    
    
    override func enable(_ shouldEnable: Bool, view: UIView) {
        super.enable(shouldEnable, view: view)
        performAdditionalCustomization(forEnabledState: shouldEnable)
    }
    
    
    
    func performAdditionalCustomization(forEnabledState enabled: Bool) {
        
        if enabled == false {
            
            dateOfVisitLabelBottomConstraint.isActive = false
            dateOfVisitStaticLabelBottomConstraint.isActive = false
            companyTextFieldBottomConstraint.isActive = true
            
            dateOfVisitStaticLabel.isHidden = true
            dateOfVisitLabel.isHidden = true
        }
        else {
            
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
        entrantCompanyDataSource = nil
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
