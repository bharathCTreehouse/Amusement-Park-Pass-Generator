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
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(toolBar)
        toolBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        toolBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        toolBar.topAnchor.constraint(equalTo: topAnchor).isActive = true
        toolBar.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        let space: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped(_:)))
        toolBar.setItems([space,doneButton], animated: false)
    }
    
    
    
    func setupDatePickerView() {
        
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        addSubview(datePicker)
        datePicker.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: toolBar.bottomAnchor, constant: 8.0).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
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
