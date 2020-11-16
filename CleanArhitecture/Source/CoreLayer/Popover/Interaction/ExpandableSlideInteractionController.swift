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
//            let translationOffset = recognizer.translation(in: presentedViewController?.view).y
//            self.presentedViewController?.view.transform = CGAffineTransform(translationX: 0,
//                                                                            y: translationOffset < 0 ? calculateLogarithmicOffset(forOffset: translationOffset) : translationOffset
//            )
            
       //     adjustFrames(toContentOffset: recognizer.translation(in: presentedViewController?.view))
            respond(to: recognizer)
            break
        case .ended:
            let translation = recognizer.translation(in: presentedViewController?.view).y
            if translation >= 25 {
                self.presentedViewController?.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10.0, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
                    self.presentedViewController?.view.transform = CGAffineTransform.identity
                }, completion: {(true) in
                })
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
            haltScrolling(scrollView)
           // trackScrolling(scrollView)
        } else {
            
        }
        
        print(scrollView.contentOffset.y)
        
    }
    
    func haltScrolling(_ scrollView: UIScrollView) {
        scrollView.setContentOffset(CGPoint(x: 0, y: scrollViewYOffset), animated: false)
        scrollView.showsVerticalScrollIndicator = false
    }
    
    func trackScrolling(_ scrollView: UIScrollView) {
        scrollViewYOffset = max(scrollView.contentOffset.y, 0)
        scrollView.showsVerticalScrollIndicator = true
    }
    
    func adjustFrames(toContentOffset contentOffset: CGPoint) {
        self.presentedViewController?.view.frame.origin.y = contentOffset.y
        self.presentedViewController?.view.frame.size.height += contentOffset.y
    }
    
    func respond(to panGestureRecognizer: UIPanGestureRecognizer) {
        let yDisplacement = panGestureRecognizer.translation(in: presentedViewController?.view).y
        adjustFrames(toContentOffset: CGPoint(x: 0, y: presentedViewController!.view.frame.origin.y + yDisplacement))
        panGestureRecognizer.setTranslation(.zero, in: presentedViewController!.view)
    }
}

extension ExpandableSlideInteractionController: PopoverViewControllerDelegate {
    func observe(scrollView: UIScrollView?) {
        scrollObserver?.invalidate()
        scrollObserver = scrollView?.observe(\.contentOffset, options: .old, changeHandler: didPanOnScrollView(_:change:))
    }
}





