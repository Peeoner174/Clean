//
//  EmployeeLoadServiceInterface.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import MoyaNetworkClient

protocol EmployeeListGateway {
    func loadEmployees(completion: @escaping ResultCompletion<[Employee]>)
}

class EmployeeListGatewayImp: EmployeeListGateway {
    
    let networkClient: DefaultMoyaNetworkClient
    
    init(networkClient: DefaultMoyaNetworkClient = ApiConfig.networkClient) {
        self.networkClient = networkClient
    }
    
    func loadEmployees(completion: @escaping ResultCompletion<[Employee]>) {
        networkClient.request(EmployeeApi.employees) { (result: Result<[Employee]>) in
            completion(result)
        }
    }
}

