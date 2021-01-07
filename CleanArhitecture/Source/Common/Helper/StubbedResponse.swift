//
//  File.swift
//  CleanArhitecture
//
//  Created by MSI on 20/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import Foundation

public func StubbedResponse(_ filename: String) -> Data! {
    let url = Bundle.main.url(forResource: filename, withExtension: "json")
    return (try? Data(contentsOf: url!))
}
