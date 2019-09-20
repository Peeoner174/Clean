//
//  Employee.swift
//  CleanArhitecture
//
//  Created by MSI on 01/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import Foundation

struct Employee: Codable {
    var name: String
    var specialization: String
    var imageURL: URL?
    var workplaces: [String]
    var email: String
    var phone: String
}
