//
//  CompletionBlocks.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import Foundation

public typealias EmptyCompletion = (() -> Void)?

public typealias ResultCompletion<T> = ((Swift.Result<T, Error>) -> Void)

public typealias Result<Success> = Swift.Result<Success, Error>


