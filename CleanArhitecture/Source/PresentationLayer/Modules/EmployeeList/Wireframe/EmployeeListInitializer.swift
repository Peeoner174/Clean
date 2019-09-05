//
//  EmployeeListEmployeeListInitializer.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

class EmployeeListModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var employeelistViewController: EmployeeListViewController!

    override func awakeFromNib() {
        EmployeeListAssembly.instance().inject(into: employeelistViewController)
    }

}
