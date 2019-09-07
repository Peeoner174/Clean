//
//  CustomPresentationManager.swift
//  CleanArhitecture
//
//  Created by MSI on 05/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

typealias Presentation = PresentationUIConfigurationProvider & PresentationAnimatorProvider

final class PopOverPresentationDelegate: NSObject {
    private var presentation: Presentation
    private var currentPresentationController: PopOverPresentationController!
    private weak var presentedViewController: UIViewController!

    public init(presentation: Presentation) {
        self.presentation = presentation
        super.init()
    }
    
    public func prepare(presentedViewController: UIViewController) {
        presentedViewController.modalPresentationStyle = .custom
        presentedViewController.transitioningDelegate = self
        self.presentedViewController = presentedViewController
    }
    
}

extension PopOverPresentationDelegate: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = PopOverPresentationController(presentedVС: presented, presentingVC: presenting, presentation: presentation)
        currentPresentationController = presentationController
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentation.showAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentation.dismissAnimator
    }
    
}


