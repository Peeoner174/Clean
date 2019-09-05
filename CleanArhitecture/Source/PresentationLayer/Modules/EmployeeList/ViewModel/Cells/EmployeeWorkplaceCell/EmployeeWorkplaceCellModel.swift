//
//  EmployeeWorkplaceCellModel.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import Foundation

class EmployeeWorkplaceCellModel: EmployeeBaseCellModel {
    override var cellIdentifier: String {
        return EmployeeWorkplaceCell.reuseIdentifier
    }
    
    var workplace: String
    
    init(_ workplace: String) {
        self.workplace = workplace
    }
}
