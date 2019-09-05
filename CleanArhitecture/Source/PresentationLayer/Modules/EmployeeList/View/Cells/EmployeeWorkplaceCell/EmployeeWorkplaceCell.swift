//
//  EmployeeWorkplaceCell.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

class EmployeeWorkplaceCell: EmployeeBaseCell {
    @IBOutlet weak var workplaceLabel: UILabel!
    
    override func updateViews() {
        guard let model = model as? EmployeeWorkplaceCellModel else {
            return
        }
        
        workplaceLabel.text = model.workplace
    }
}
