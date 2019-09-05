//
//  EmployeeListEmployeeListConfigurator.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit
import EasyDi

class EmployeeListAssembly: Assembly {
    
    lazy var usecaseAssembly: UseCasesAssembly = self.context.assembly()
    
    var view: EmployeeListViewInput {
        return definePlaceholder()
    }
    
    var router: EmployeeListRouterInput {
        return define(
            scope: .prototype,
            init: EmployeeListRouter()
        )
    }
    
    var presentor: EmployeeListPresenter {
        return define(
            scope: .prototype,
            init: EmployeeListPresenterImpl(
                view: self.view,
                router: self.router,
                employeeListUsecase: self.usecaseAssembly.employeeListUsecase)
        )
    }
    
    func inject(into viewController: EmployeeListViewController) {
        defineInjection(
            key: "view",
            into: viewController) {
                $0.presenter = self.presentor
                return $0
        }
    }
    
}
