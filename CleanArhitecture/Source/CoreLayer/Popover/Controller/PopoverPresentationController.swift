//
//  CustomPresentationController.swift
//  CleanArhitecture
//
//  Created by MSI on 05/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

protocol PopoverPresentationControllerProtocol: UIPresentationController, UIGestureRecognizerDelegate {
    var didTapBackgroundView: EmptyCompletion { get set }
    func updatePresentation(presentation: Presentation, duration: Duration)
}

final class PopoverPresentationController: UIPresentationController, PopoverPresentationControllerProtocol {
    private var presentation: Presentation
    private weak var popOverPresentationDelegate: PopoverPresentationDelegate?
    
    // MARK: - Views
    private lazy var backgroundView: BackgroundDesignable = {
        let view: BackgroundDesignable
        switch self.presentation.presentationUIConfiguration.backgroundStyle {
        case .dimmed(alpha: let alpha):
            view = DimmedView(dimAlpha: alpha)
        case .blurred(effectStyle: let effectStyle):
            view = BluredView(effectStyle: effectStyle)
        case .clear(shouldPassthrough: let shouldPassthrough):
            view = PassthroughBackgroundView(shouldPassthrough: shouldPassthrough, presentingVC: presentingViewController)
        }
        
        view.didTap = { [weak self] _ in
            guard self?.presentation.presentationUIConfiguration.isTapBackgroundToDismissEnabled ?? false else {
                return
            }
            self?.didTapBackgroundView?()
        }
        
        return view
    }()
    
    var didTapBackgroundView: EmptyCompletion = nil
    
    private lazy var popOverContainerView: PopoverContainerView = {
        let frame = containerView?.frame ?? .zero
        return PopoverContainerView(presentedView: presentedViewController.view, frame: frame)
    }()
    
    override var presentedView: UIView {
        return popOverContainerView
    }
    
    // MARK: - Initializers

    init(presentedVС: UIViewController, presentingVC: UIViewController?, presentation: Presentation, delegate: PopoverPresentationDelegate?) {
        self.presentation = presentation
        self.popOverPresentationDelegate = delegate
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
            }, completion: { [weak self] _ in
                self?.popOverPresentationDelegate?.didDismiss?()
        })
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        self.popOverPresentationDelegate!.frameOfPresentedView(in: containerView!.frame)
    }
    
    func updatePresentation(presentation: Presentation, duration: Duration) {
        self.presentation = presentation
        containerView?.setNeedsLayout()
        UIView.animate(withDuration: duration.timeInterval) {
            self.containerView?.layoutIfNeeded()
        }
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return self.popOverPresentationDelegate!.frameOfPresentedView(in: containerView!.frame).size
    }
}

extension PopoverPresentationController {
    
    func layoutBackgroundView(in containerView: UIView) {
        containerView.insertSubview(backgroundView, at: 0)
        backgroundView.fillSuperview()
    }
    
    func layoutPresentedView(in: UIView) {
        containerView?.addSubview(presentedView)
        presentedView.frame = frameOfPresentedViewInContainerView
    }
    
    func configureViewLayout() {
//        presentedViewController.view.frame = frameOfPresentedViewInContainerView
        presentedView.frame = frameOfPresentedViewInContainerView
        let corners = presentation.presentationUIConfiguration.corners
        let radius = presentation.presentationUIConfiguration.cornerRadius
        presentedView.roundCorners(corners, radius: radius)
    }
}
