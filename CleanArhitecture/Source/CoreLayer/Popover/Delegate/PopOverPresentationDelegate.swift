//
//  CustomPresentationManager.swift
//  CleanArhitecture
//
//  Created by MSI on 05/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

@objc
public protocol PopOverPresentationDelegate: UIViewControllerTransitioningDelegate {
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect
    @objc optional func didDismiss()
}

typealias Presentation = PresentationUIConfigurationProvider & PresentationAnimatorProvider
typealias FrameOfPresentedViewClosure = ((_ containerViewFrame: CGRect) -> CGRect)?

final class PopOverPresentationDelegateImpl: NSObject {
    private var presentation: Presentation
    
   // private var currentPresentationController: PopOverPresentationController!
    private weak var presentedViewController: UIViewController!
    
    private var frameOfPresentedView: FrameOfPresentedViewClosure
    private var dismissCompletion: EmptyCompletion

    var presentInteractionController: InteractionController?
    var dismissInteractionController: InteractionController?
    var presentationController: PopOverPresentationController!
    
    public init(presentation: Presentation,
                frameOfPresentedView: FrameOfPresentedViewClosure,
                dismissCompletion: EmptyCompletion = nil) {
        
        self.presentation = presentation
        self.frameOfPresentedView = frameOfPresentedView
        self.dismissCompletion = dismissCompletion
        super.init()
    }
    
    public func prepare(presentedViewController: UIViewController) {
        presentedViewController.modalPresentationStyle = .custom
        presentedViewController.transitioningDelegate = self
        self.presentedViewController = presentedViewController
    }
}

extension PopOverPresentationDelegateImpl: PopOverPresentationDelegate {
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        return frameOfPresentedView?(containerViewFrame) ?? containerViewFrame
    }
    
    func didDismiss() {
        dismissCompletion?()
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = PopOverPresentationController(presentedVС: presented, presentingVC: presenting, presentation: presentation, delegate: self)
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentation.showAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentation.dismissAnimator
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return dismissInteractionController
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return dismissInteractionController
    }
}


