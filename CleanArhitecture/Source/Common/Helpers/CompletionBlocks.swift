//
//  CompletionBlocks.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import Foundation

typealias EmptyCompletion = (() -> Void)?

typealias ResultCompletion<T> = ((Result<T, Error>) -> Void)

