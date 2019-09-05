//
//  EmployeeListUsecaseImp.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import Foundation

final class EmployeeListUsecaseImp: EmployeeListUsecase {
    let employeeListGateway: EmployeeListGateway
    
    init(employeeListGateway: EmployeeListGateway) {
        self.employeeListGateway = employeeListGateway
    }

    func getEmployees(completion: @escaping ResultHandlerCompletion<[Employee]>) {
        employeeListGateway.loadEmployees(completion: completion)
    }
    
}
