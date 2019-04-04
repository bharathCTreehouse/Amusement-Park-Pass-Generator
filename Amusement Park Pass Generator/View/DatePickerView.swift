//
//  DatePickerView.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 13/03/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit



class DatePickerView: UIView {
    
    var completionHandler: ((Date) -> Void)? = nil
    var toolBar: UIToolbar = UIToolbar(frame:.zero)
    var datePicker: UIDatePicker = UIDatePicker(frame: .zero)
    
    
    init(withCompletionHandler completion: @escaping ((Date) -> Void)) {
        completionHandler = completion
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupToolBar()
        setupDatePickerView()
    }
    
    
    func setupToolBar() {
        
        toolBar.barStyle = .blackOpaque
        addSubview(toolBar)
        toolBar.configure(withConstraints: [.leading(referenceConstraint: leadingAnchor, constantOffSet: 0.0, equalityType: .equalTo), .trailing(referenceConstraint: trailingAnchor, constantOffSet: 0.0, equalityType: .equalTo), .top(referenceConstraint: topAnchor, constantOffSet: 0.0, equalityType: .equalTo), .height(constantOffSet: 60.0, equalityType: .equalTo)])
        let space: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped(_:)))
        toolBar.setItems([space,doneButton], animated: false)
    }
    
    
    
    func setupDatePickerView() {
        
        datePicker.datePickerMode = .date
        addSubview(datePicker)
        datePicker.configure(withConstraints: [.leading(referenceConstraint: leadingAnchor, constantOffSet: 0.0, equalityType: .equalTo), .trailing(referenceConstraint: trailingAnchor, constantOffSet: 0.0, equalityType: .equalTo), .top(referenceConstraint: toolBar.bottomAnchor, constantOffSet: 8.0, equalityType: .equalTo), .bottom(referenceConstraint: bottomAnchor, constantOffSet: 0.0, equalityType: .equalTo)])
        datePicker.backgroundColor = UIColor.clear
    }
    
    
    @objc private func doneButtonTapped(_ sender: UIBarButtonItem) {
        completionHandler?(datePicker.date)
    }

    
    func closeDatePickerView() {
        completionHandler?(datePicker.date)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    deinit {
        completionHandler = nil
    }
    
}
