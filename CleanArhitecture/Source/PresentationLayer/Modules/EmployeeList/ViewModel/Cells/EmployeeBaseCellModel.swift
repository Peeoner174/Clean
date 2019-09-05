//
//  EmployeeBaseCellModel.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

class EmployeeBaseCellModel: CellIdentifiable {
    let automaticHeight: Float = -1.0
    
    var cellIdentifier: String {
        return EmployeeBaseCell.reuseIdentifier
    }
    
    var cellHeight: Float {
        return automaticHeight
    }
}
