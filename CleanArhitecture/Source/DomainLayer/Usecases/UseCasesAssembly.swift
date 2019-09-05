//
//  UsecaseAssemblies.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import EasyDi

final class UseCasesAssembly: Assembly {
    
    private lazy var gatewaysAssembly: GatewaysAssembly = self.context.assembly()
    
    var employeeListUsecase: EmployeeListUsecase {
        return define(
            scope: .prototype,
            init: EmployeeListUsecaseImp(employeeListGateway: self.gatewaysAssembly.employeeListGateway)
        )
    }
    
}
