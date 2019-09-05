//
//  EmployeeListPresenter.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import Foundation

protocol EmployeeListPresenter {
    func viewIsReady()
    func employeesDidReceive(_ employees: [Employee])
}
