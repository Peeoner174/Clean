//
//  CustomPresentationController.swift
//  CleanArhitecture
//
//  Created by MSI on 05/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

final class PopOverPresentationController: UIPresentationController {
    
    // MARK: - Views
    
    private lazy var backgroundView: UIView = {
        
        return UIView(frame: .zero)
    }()
    
    /**
     A wrapper around the presented view so that we can modify
     the presented view apperance without changing
     the presented view's properties
     */
    private lazy var panContainerView: PopOverContainerView = {
        let frame = containerView?.frame ?? .zero
        return PopOverContainerView(presentedView: presentedViewController.view, frame: frame)
    }()
    
    /**
     Override presented view to return the pan container wrapper
     */
    public override var presentedView: UIView {
        return panContainerView
    }
    
    // MARK: - Initializers

    init(presentedVС: UIViewController, presentingVC: UIViewController?) {
        super.init(presentedViewController: presentedVС, presenting: presentingVC)
    }
    
    // MARK: - Lifecycle
    
    override public func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        configureViewLayout()
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        
        layoutBackgroundView(in: containerView)
        layoutPresentedView(in: containerView)
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            return
        }
        
        coordinator.animate(alongsideTransition: { [weak self] _ in
            
        })
        
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            return
        }
        
        coordinator.animate(alongsideTransition: { [weak self] _ in
            
        })
    }
    
}



extension PopOverPresentationController {
    
    func  layoutBackgroundView(in: UIView) {
        
    }
    
    func layoutPresentedView(in: UIView) {
     
    }
    
    func configureViewLayout() {
        
    }
    
}
