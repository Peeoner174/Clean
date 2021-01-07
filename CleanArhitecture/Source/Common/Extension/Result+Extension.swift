//
//  Result+Extension.swift
//  CleanArhitecture
//
//  Created by MSI on 17/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import Foundation

extension Result {
    func handle(onFail failureHandler: (Failure) -> Void, onSuccess successHandler: (Success) -> Void) {
        switch self {
        case .failure(let failure):
            failureHandler(failure)
        case .success(let success):
            successHandler(success)
        }
    }
    
    func handle(onFail failureHandler: @autoclosure () -> Never, onSuccess successHandler: (Success) -> Void) {
        switch self {
        case .failure(_):
            failureHandler()
        case .success(let success):
            successHandler(success)
        }
    }
}
