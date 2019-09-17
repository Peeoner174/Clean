//
//  EmployeeLoadServiceInterface.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import Foundation

protocol EmployeeListGateway {
    func loadEmployees(completion: @escaping ResultHandlerCompletion<[Employee]>)
}

class EmployeeListGatewayImp: EmployeeListGateway {
    
    func loadEmployees(completion: @escaping ResultHandlerCompletion<[Employee]>) {
        let names = ["Sergei", "Dmitriy", "Ruslan"]
        let specializations = ["Network Administrator", "Data Scientist", "Android-Developer"]
        let emails = ["sergei@mail.com", "dima@mail.com", "ruslan@mail.com"]
        let phones = ["+7 (926) 000-00-76", "+7 (999) 999-99-99", "+7 (909) 000-00-00"]
        let workplaces = [["NapoleonIT", "ООО «НОВАТЭК-АЗК»", "ООО «Урал-НЭТ»"],
                          ["SNAFU"],
                          ["Rutube", "NapoleonIT"]]
        
        var employees = [Employee]()
        
        for i in 0..<3 {
            let imageURL = Bundle.main.url(forResource: "Employee\(i)", withExtension: "jpg")
            employees.append(Employee(name: names[i],
                                      specialization: specializations[i],
                                      imageURL: imageURL,
                                      workplaces: workplaces[i],
                                      email: emails[i],
                                      phone: phones[i]))
        }
        
        completion(.success(employees))
    }
}

