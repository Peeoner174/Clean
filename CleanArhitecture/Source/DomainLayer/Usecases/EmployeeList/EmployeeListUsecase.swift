//
//  EmployeeListUsecase.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import Foundation

protocol EmployeeListUsecase {
    func getEmployees(completion: @escaping ResultCompletion<[Employee]>)
}

final class EmployeeListUsecaseImp: EmployeeListUsecase {
    let employeeListGateway: EmployeeListGateway
    
    init(employeeListGateway: EmployeeListGateway) {
        self.employeeListGateway = employeeListGateway
    }
    
    func getEmployees(completion: @escaping ResultCompletion<[Employee]>) {
        employeeListGateway.loadEmployees(completion: completion)
    }
    
}
