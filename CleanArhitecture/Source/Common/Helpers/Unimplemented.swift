//
//  Unimplemented.swift
//  CleanArhitecture
//
//  Created by MSI on 17/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

public func Unimplemented(_ fn: String = #function, file: StaticString = #file, line: UInt = #line) -> Never {
    fatalError("❗️ \(fn) is not yet full implemented", file: file, line: line)
}
