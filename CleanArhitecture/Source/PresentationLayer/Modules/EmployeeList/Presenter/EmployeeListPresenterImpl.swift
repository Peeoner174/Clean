//
//  EmployeeListEmployeeListPresenter.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

class EmployeeListPresenterImpl {

    weak var view: EmployeeListViewInput!
    var employeeListUsecase: EmployeeListUsecase
    var router: EmployeeListRouterInput
    
    init(view: EmployeeListViewInput, router: EmployeeListRouterInput, employeeListUsecase: EmployeeListUsecase) {
        self.view = view
        self.employeeListUsecase = employeeListUsecase
        self.router = router
    }
}

extension EmployeeListPresenterImpl: EmployeeSectionModelDelegate {
    func didTapText(withEmail email: String) {
        print("Will text to \(email)")
    }
    
    func didTapCall(withPhone phoneNumber: String) {

    }
}

extension EmployeeListPresenterImpl: EmployeeListPresenter {
    
    func viewIsReady() {
        employeeListUsecase.getEmployees { (result) in
            result.handle(onFail: Unimplemented(), onSuccess: self.employeesDidReceive(_:))
        }
    }
    
    func employeesDidReceive(_ employees: [Employee]) {
        var sections = [EmployeeSectionModel]()
        employees.forEach({
            let section = EmployeeSectionModel($0)
            section.delegate = self
            
            sections.append(section)
        })
        
        view.updateForSections(sections)
    }
}
