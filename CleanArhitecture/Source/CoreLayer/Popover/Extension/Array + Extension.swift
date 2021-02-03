//
//  Array + Extension.swift
//  CleanArhitecture
//
//  Created by MSI on 15.12.2020.
//  Copyright © 2020 IA. All rights reserved.
//

import Foundation

extension Array {
    subscript(guarded idx: Int) -> Element? {
        guard (startIndex..<endIndex).contains(idx) else {
            return nil
        }
        return self[idx]
    }
    
    subscript(guarded idx: UInt8) -> Element? {
        guard (startIndex..<endIndex).contains(Int(idx)) else {
            return nil
        }
        return self[Int(idx)]
    }
}
