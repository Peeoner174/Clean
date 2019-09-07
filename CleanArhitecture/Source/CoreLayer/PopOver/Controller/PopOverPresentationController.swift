//
//  CustomPresentationController.swift
//  CleanArhitecture
//
//  Created by MSI on 05/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

final class PopOverPresentationController: UIPresentationController {
    private let presentation: Presentation
    
    // MARK: - Views
    var backgroundView: BackgroundDesignable {
        let view: BackgroundDesignable
        switch self.presentation.presentationUIConfiguration.backgroundStyle {
        case .dimmed(alpha: let alpha):
            view = DimmedView(dimAlpha: alpha)
        case .blurred(effectStyle: let effectStyle):
            view = BluredView(effectStyle: effectStyle)
        }
        
        view.didTap = { [weak self] _ in
            self?.dismissPresentedViewController()
        }
    }
    
    func dismissPresentedViewController() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    /**
     A wrapper around the presented view so that we can modify
     the presented view apperance without changing
     the presented view's properties
     */
    private lazy var popOverContainerView: PopOverContainerView = {
        let frame = containerView?.frame ?? .zero
        return PopOverContainerView(presentedView: presentedViewController.view, frame: frame)
    }()
    
    /**
     Override presented view to return the pan container wrapper
     */
    public override var presentedView: UIView {
        return popOverContainerView
    }
    
    // MARK: - Initializers

    init(presentedVС: UIViewController, presentingVC: UIViewController?, presentation: Presentation) {
        self.presentation = presentation
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
    
    func layoutBackgroundView(in containerView: UIView) {
        containerView.addSubview(<#T##view: UIView##UIView#>)
    }
    
    func layoutPresentedView(in: UIView) {
     
    }
    
    func configureViewLayout() {
        
    }
    
}
