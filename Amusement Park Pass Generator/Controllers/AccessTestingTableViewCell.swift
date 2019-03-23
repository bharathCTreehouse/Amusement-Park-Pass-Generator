//
//  AccessTestingTableViewCell.swift
//  Amusement Park Pass Generator
//
//  Created by Bharath Chandrashekar on 17/03/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import UIKit

protocol AccessTestingCellProtocol: class {
    
    func testAccess(forKiosk kiosk: KioskType)
}


class AccessTestingTableViewCell: UITableViewCell {
    
    weak var delegate: AccessTestingCellProtocol? = nil
    @IBOutlet var testResultLabel: UILabel!
    @IBOutlet var testDetailLabel: UILabel!
    @IBOutlet var specialMessageLabel: UILabel!
    @IBOutlet var visualTestResultView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .none
    }
    
    
    deinit {
        delegate = nil
        testResultLabel = nil
        testDetailLabel = nil
        specialMessageLabel = nil
        visualTestResultView = nil
    }
    
}



extension AccessTestingTableViewCell {
    
    @IBAction func amusementKioskTapped(_ sender: UIButton) {
        delegate?.testAccess(forKiosk: .amusement)
    }
    
    @IBAction func kitchenKioskTapped(_ sender: UIButton) {
        delegate?.testAccess(forKiosk: .kitchen)
    }
    
    @IBAction func rideControlKioskTapped(_ sender: UIButton) {
        delegate?.testAccess(forKiosk: .rideControl)
    }
    
    @IBAction func maintenanceKioskTapped(_ sender: UIButton) {
        delegate?.testAccess(forKiosk: .maintenance)
    }
    
    @IBAction func officeKioskTapped(_ sender: UIButton) {
        delegate?.testAccess(forKiosk: .office)
    }
    
    @IBAction func rideKioskTapped(_ sender: UIButton) {
        delegate?.testAccess(forKiosk: .ride)
    }
    
    @IBAction func foodKioskTapped(_ sender: UIButton) {
        delegate?.testAccess(forKiosk: .food)
    }
    
    @IBAction func merchandiseKioskTapped(_ sender: UIButton) {
        delegate?.testAccess(forKiosk: .merchandise)
    }
}
