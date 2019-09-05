//
//  EmployeeBaseInfoCellModel.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import Foundation

class EmployeeBaseInfoCellModel: EmployeeBaseCellModel {
    override var cellIdentifier: String {
        return EmployeeBaseInfoCell.reuseIdentifier
    }
    
    var name: String
    var specialization: String
    var imageURL: URL?
    
    init(_ employee: Employee) {
        name = employee.name
        specialization = employee.specialization
        imageURL = employee.imageURL
    }
}
