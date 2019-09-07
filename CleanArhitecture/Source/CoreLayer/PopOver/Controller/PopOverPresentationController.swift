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
    //weak public var sizeDelegate:
    
    // MARK: - Views
    var backgroundView: BackgroundDesignable {
        let view: BackgroundDesignable
        switch self.presentation.presentationUIConfiguration.backgroundStyle {
        case .dimmed(alpha: let alpha):
            view = DimmedView(dimAlpha: alpha)
        case .blurred(effectStyle: let effectStyle):
            view = BluredView(effectStyle: effectStyle)
        case .clear(shouldPassthrough: let shouldPassthrough):
            view = PassthroughBackgroundView(shouldPassthrough: shouldPassthrough)
        }
        
        view.didTap = { [weak self] _ in
            self?.dismissPresentedViewController()
        }
        
        return view
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
            self?.backgroundView.onPresent()
            self?.presentedViewController.setNeedsStatusBarAppearanceUpdate()
        })
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            return
        }
        
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.backgroundView.onDissmis()
            self?.presentedViewController.setNeedsStatusBarAppearanceUpdate()
        })
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        //return (sizeDelegate ?? self).frameOfPresentedView(in: containerView!.frame)
        return CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)
    }
}

extension PopOverPresentationController {
    
    func layoutBackgroundView(in containerView: UIView) {
        containerView.insertSubview(backgroundView, at: 0)
        // backgroundView.fillSuperview()
        containerView.subviews.first?.fillView(containerView)
    }
    
    func layoutPresentedView(in: UIView) {
        containerView?.addSubview(presentedView)
        presentedView.frame = frameOfPresentedViewInContainerView
    }
    
    func configureViewLayout() {
        let corners = presentation.presentationUIConfiguration.corners
        let radius = presentation.presentationUIConfiguration.cornerRadius
        presentedView.roundCorners(corners, radius: radius)
    }
}
