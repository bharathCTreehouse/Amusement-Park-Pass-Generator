//
//  MiscEntrantInformationTableViewCell.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 13/03/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import UIKit

class MiscEntrantInformationTableViewCell: EntrantInformationTableViewCell {
    
    @IBOutlet private(set) var dateOfBirthTextField: UITextField!
    @IBOutlet private(set) var ssnNumberTextField: UITextField!
    @IBOutlet private(set) var projectNumberTextField: UITextField!
    @IBOutlet private(set) var dateOfBirthLabel: UILabel!
    @IBOutlet private(set) var ssnNumberLabel: UILabel!
    @IBOutlet private(set) var projectNumberLabel: UILabel!
    
    
    private(set) var miscInformationDataSource: MiscEntrantInfoDataSource? = nil {
        
        didSet {
            
            if miscInformationDataSource == nil {
                
                dateOfBirthTextField.text = nil
                projectNumberTextField.text = nil

            }
            else {
                
                if miscInformationDataSource!.dateOfBirth == nil {
                    dateOfBirthTextField.text = nil
                }
                else {
                    dateOfBirthTextField.text = miscInformationDataSource!.dateOfBirth!.string(withDateFormat: "MM/dd/yyyy")
                }
                
                if miscInformationDataSource!.project == nil {
                    projectNumberTextField.text = nil
                }
                else {
                    projectNumberTextField.text = miscInformationDataSource!.project!.displayString
                }
            }
            
        }
    }
    
    
    func updateDataSource(with dataSource: MiscEntrantInfoDataSource) {
        miscInformationDataSource = dataSource
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dateOfBirthTextField.delegate = self
        projectNumberTextField.delegate = self
        
        dateOfBirthTextField.inputView = DatePickerView(withCompletionHandler: { [unowned self] (selectedDate: Date) in
            
            self.dateOfBirthTextField.delegate = nil
            
            self.miscInformationDataSource?.updateBirthDate(with: selectedDate)
            self.updateDataSource(with: self.miscInformationDataSource!)
            
            self.endEditing(true)
            
            self.dateOfBirthTextField.delegate = self
            
        })
        
        
        projectNumberTextField.inputView = SelectionPickerView(withPickerList: ProjectRegistered.orderedDisplayableProjectList(), completionHandler:
            
            { [unowned self] (selectedIndex: Int)  in
                
                self.projectNumberTextField.delegate = nil
                
                let projectRegistered: ProjectRegistered = ProjectRegistered.orderedProjectList()[selectedIndex]
                self.miscInformationDataSource?.updateProject(with: projectRegistered)
                self.updateDataSource(with: self.miscInformationDataSource!)
                
                self.endEditing(true)
                
                self.projectNumberTextField.delegate = self
                
        })
    }
    
    
    
    override func enable(_ shouldEnable: Bool, view: UIView) {
        
        super.enable(shouldEnable, view: view)
        
        if view == dateOfBirthTextField {
            dateOfBirthLabel.alpha = (shouldEnable == true) ? 1.0 : 0.1
        }
        else if view == ssnNumberTextField {
            ssnNumberLabel.alpha = (shouldEnable == true) ? 1.0 : 0.1
        }
        else if view == projectNumberTextField {
            projectNumberLabel.alpha = (shouldEnable == true) ? 1.0 : 0.1
        }
    }
    
    
    
    deinit {
        dateOfBirthTextField = nil
        ssnNumberTextField = nil
        projectNumberTextField = nil
        dateOfBirthLabel = nil
        ssnNumberLabel = nil
        projectNumberLabel = nil
        miscInformationDataSource = nil
    }

}



extension MiscEntrantInformationTableViewCell {
    
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == dateOfBirthTextField {
            
            let datePickerViewView: DatePickerView? = (dateOfBirthTextField?.inputView) as? DatePickerView
            
            if let datePickerViewView = datePickerViewView {
                datePickerViewView.closeDatePickerView()
            }
            
        }
        else if textField == projectNumberTextField {
            
            let selectionView: SelectionPickerView? = (projectNumberTextField?.inputView) as? SelectionPickerView
            
            if let selectionView = selectionView {
                selectionView.closeSelectionPickerView()
            }
        }
        
    }
}
