//
//  CustomPresentationManager.swift
//  CleanArhitecture
//
//  Created by MSI on 05/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

final class PopOverPresentationDelegate: NSObject {
    
    var direction: PresentationDirection = .bottom
    
    override init() {
        super.init()
    }
    
}

extension PopOverPresentationDelegate: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PopOverPresentationController(presentedVС: presented, presentingVC: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopOverAnimator(transitionStyle: .presentation, direction: direction)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopOverAnimator(transitionStyle: .dismissal, direction: direction)
    }
    
}


