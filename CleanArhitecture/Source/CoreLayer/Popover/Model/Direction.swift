//
//  Direction.swift
//  CleanArhitecture
//
//  Created by MSI on 06/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

public enum Direction {
    case top
    case bottom
    case left
    case right
}

extension Direction {

    func offsetFrameForView(view: UIView, containerView: UIView) -> CGRect {
        
        var frame = view.frame
        
        switch self {
        case .left:
            frame.origin.x = -frame.width
        case .right:
            frame.origin.x = containerView.bounds.width
        case .top:
            frame.origin.y = -frame.height
        case .bottom:
            frame.origin.y = containerView.bounds.height
        }
        
        return frame
    }
}

