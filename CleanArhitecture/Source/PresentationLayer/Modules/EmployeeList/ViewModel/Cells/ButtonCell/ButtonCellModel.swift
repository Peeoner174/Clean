//
//  ButtonCellModel.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import Foundation

class ButtonCellModel: EmployeeBaseCellModel {
    typealias ActionHandler = () -> ()
    
    override var cellIdentifier: String {
        return ButtonCell.reuseIdentifier
    }
    
    var action: ActionHandler?
    var title: String
    
    init(title: String, action: ActionHandler? = nil) {
        self.title = title
        self.action = action
    }
}
