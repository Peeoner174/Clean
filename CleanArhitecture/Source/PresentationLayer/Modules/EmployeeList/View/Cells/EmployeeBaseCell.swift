//
//  EmployeeBaseCell.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

class EmployeeBaseCell: UITableViewCell, ModelRepresentable {
    var model: CellIdentifiable? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        
    }
}
