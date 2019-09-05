//
//  CustomPresentationAnimator.swift
//  CleanArhitecture
//
//  Created by MSI on 05/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

enum PresentationDirection {
    case left
    case top
    case right
    case bottom
    case center
}

final class PopOverAnimator: NSObject {
    
    public enum TransitionStyle {
        case presentation
        case dismissal
    }
    
    // MARK: - Properties
    
    private let transitionStyle: TransitionStyle
    let direction: PresentationDirection
    
    // MARK: - Initializers
    
    required public init(transitionStyle: TransitionStyle, direction: PresentationDirection) {
        self.transitionStyle = transitionStyle
        self.direction = direction
        super.init()
    }

}

extension PopOverAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch transitionStyle {
        case .presentation:
            break
        case .dismissal:
            break
        }
    }
    
}

