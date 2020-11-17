//
//  File.swift
//  CleanArhitecture
//
//  Created by Pavel Kochenda on 11.11.2020.
//  Copyright © 2020 IA. All rights reserved.
//

import UIKit

class ExpandableSlideInteractionController: UIPercentDrivenInteractiveTransition {
    private var shouldCompleteTransition = false
    
    weak private var presentedViewController: UIViewController?
    weak private var presentationController: PopoverPresentationControllerProtocol?
    
    private let transitionType: TransitionType
    
    var interactionAction: (() -> ())?
    private lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(didPanOnPresentedView(_ :)))
        gesture.minimumNumberOfTouches = 1
        gesture.maximumNumberOfTouches = 1
        gesture.delegate = presentationController
        return gesture
    }()
    
    // MARK: - ScrollView expanding PopOver properties
    
    /// An observer for the scroll view content offset
    private var scrollObserver: NSKeyValueObservation?
    private var scrollViewYOffset: CGFloat = 0.0
    private var expandLimitReachead: Bool = false
    
    init(presentedViewController: UIViewController,
         presentationController: PopoverPresentationControllerProtocol,
         transitionType: TransitionType
    ) {
        
        self.presentedViewController = presentedViewController
        self.presentationController = presentationController
        self.transitionType = transitionType
        
        super.init()
    }
    
    deinit {
        scrollObserver?.invalidate()
    }
    
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        super.startInteractiveTransition(transitionContext)
        let containerView = transitionContext.containerView
    
        containerView.addGestureRecognizer(panGestureRecognizer)
            
        presentationController?.didTapBackgroundView = { [weak self] in
            guard let self = self else { return }
            self.presentedViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func didPanOnPresentedView(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            break
        case .changed:
            if presentedViewController!.view.frame.height < 550 {
                respond(to: recognizer)
            } else {           }
        case .ended: 
            let translation = recognizer.translation(in: presentedViewController?.view).y

            do {
                try (presentationController as! PopoverFrameTweakable).updateFrame(
                    currentFrame: presentedViewController!.view.frame,
                    duration: .medium,
                    direction: translation > 0 ? .bottom : .top
                )
            } catch let error {
                guard let error = error as? LiveUpdateError else {
                    return
                }
                switch error {
                case .reachedExpandMaximum:
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10.0, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
                        self.presentedViewController?.view.transform = CGAffineTransform.identity
                    }, completion: {(true) in
                    })
                case .reachedExpandMinimum:
                    self.presentedViewController?.dismiss(animated: true, completion: nil)
                default:
                    return
                }
            }
        default:
            break
        }
    }
    
    private func calculateLogarithmicOffset(forOffset offset: CGFloat) -> CGFloat {
        return offset * ((1 - log2(abs(offset)) / 10) )
    }
    
    // MARK: - ScrollView expanding PopOver methods
    
    func didPanOnScrollView(_ scrollView: UIScrollView, change: NSKeyValueObservedChange<CGPoint>) {
        guard
            let presentedViewController = self.presentedViewController,
            !presentedViewController.isBeingDismissed,
            !presentedViewController.isBeingPresented
            else { return }
        
        if scrollView.isScrolling {
            if presentedViewController.view.frame.height < 550 {
                haltScrolling(scrollView)
            } else {
                trackScrolling(scrollView)
            }
        } else {

        }
    }
    
    func haltScrolling(_ scrollView: UIScrollView) {
        scrollView.setContentOffset(CGPoint(x: 0, y: scrollViewYOffset), animated: false)
        scrollView.showsVerticalScrollIndicator = false
    }
    
    func trackScrolling(_ scrollView: UIScrollView) {
        scrollViewYOffset = max(scrollView.contentOffset.y, 0)
        scrollView.showsVerticalScrollIndicator = true
    }
    
    func adjustFrames(to displacement: CGPoint) {
        self.presentedViewController?.view.frame.origin.y = displacement.y
        self.presentedViewController?.view.frame.size.height = UIScreen.main.bounds.size.height - self.presentedViewController!.view.frame.origin.y
    }
    
    func respond(to panGestureRecognizer: UIPanGestureRecognizer) {
        let yDisplacement = panGestureRecognizer.translation(in: presentedViewController?.view).y
        adjustFrames(to: CGPoint(x: 0, y: presentedViewController!.view.frame.origin.y + yDisplacement))
        panGestureRecognizer.setTranslation(.zero, in: presentedViewController!.view)
    }
}

extension ExpandableSlideInteractionController: PopoverViewControllerDelegate {
    func observe(scrollView: UIScrollView?) {
        scrollObserver?.invalidate()
        scrollObserver = scrollView?.observe(\.contentOffset, options: .old, changeHandler: didPanOnScrollView(_:change:))
    }
}





