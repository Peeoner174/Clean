//
//  CatalogApi.swift
//  CleanArhitecture
//
//  Created by MSI on 19/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import Moya
import MoyaNetworkClient

fileprivate struct EmployeeApiConfig {
    static let urlBase = ApiConfig.urlBase
}

enum EmployeeApi {
    case employees
}

extension EmployeeApi: MoyaTargetType {
    var route: Route {
        return .get("/employees")
    }
    
    var baseURL: URL {
        return try! EmployeeApiConfig.urlBase.asURL()
    }
    
    var sampleData: Data {
        return StubbedResponse("employees")
    }
    
    var task: Task {
        return .requestParameters(parameters: [:], encoding: URLEncoding.default)
    }
}

