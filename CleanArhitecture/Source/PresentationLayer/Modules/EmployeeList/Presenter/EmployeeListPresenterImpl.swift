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
        let presentedVC = EmployeeListViewController.instantiate()
        let presentation = SlidePresentation(direction: .bottom, uiConfiguration: PresentationUIConfiguration())
        
        PopoverManager.present(
            vc: presentedVC,
            in: self.view as! UIViewController,
            presentation: presentation,
            frameOfPresentedView: { containerViewFrame in
                let height = CGFloat(300)
                return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height - height + 10), size: CGSize(width: containerViewFrame.width, height: height))
        })

        print("Will call to \(phoneNumber)")
    }
}

extension EmployeeListPresenterImpl: EmployeeListPresenter {
    
    func viewIsReady() {
        employeeListUsecase.getEmployees { (result) in
            try! self.employeesDidReceive(result.get())
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
