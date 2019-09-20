//
//  GatewaysAssembly.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import EasyDi
import MoyaNetworkClient

final class GatewaysAssembly: Assembly {
    
    var employeeListGateway: EmployeeListGateway {
        return define(
            scope: .prototype,      
            init: EmployeeListGatewayImp()
        )
    }
    
}
