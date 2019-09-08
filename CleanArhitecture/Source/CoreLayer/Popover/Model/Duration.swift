//
//  Duration.swift
//  CleanArhitecture
//
//  Created by MSI on 06/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import Foundation

public enum Duration {
    case custom(duration: TimeInterval)
    case ultraSlow
    case slow
    case medium
    case normal
    case fast
    case reallyFast
    
    var timeInterval: TimeInterval {
        switch self {
        case .custom(let duration):
            return duration
        case .ultraSlow:
            return 2.0
        case .slow:
            return 1.0
        case .medium:
            return 0.5
        case .normal:
            return 0.35
        case .fast:
            return 0.2
        case .reallyFast:
            return 0.1
        }
    }
}
