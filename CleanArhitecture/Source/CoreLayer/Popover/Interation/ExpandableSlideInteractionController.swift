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
    private var frameOfPresentedView: FrameOfPresentedViewClosure
    
    var interactionAction: (() -> ())?
    private lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(didPanOnPresentedView(_ :)))
        gesture.minimumNumberOfTouches = 1
        gesture.maximumNumberOfTouches = 1
        gesture.delegate = presentationController
        return gesture
    }()
    
    init(presentedViewController: UIViewController,
         presentationController: PopoverPresentationControllerProtocol,
         transitionType: TransitionType,
         frameOfPresentedView: FrameOfPresentedViewClosure) {

        self.presentedViewController = presentedViewController
        self.presentationController = presentationController
        self.transitionType = transitionType
        self.frameOfPresentedView = frameOfPresentedView

        super.init()
    }
    
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        super.startInteractiveTransition(transitionContext)
        let containerView = transitionContext.containerView
        containerView.addGestureRecognizer(panGestureRecognizer)
        
        presentationController?.didTapBackgroundView = {
            self.presentedViewController?.dismiss(animated: true, completion: nil)
        }
    }

    @objc func didPanOnPresentedView(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            
            break
        case .changed:
            let translationOffset = recognizer.translation(in: presentedViewController?.view).y
            self.presentedViewController?.view.transform = CGAffineTransform(translationX: 0,
                                                                            y: translationOffset < 0 ? calculateLogarithmicOffset(forOffset: translationOffset) : translationOffset
            )
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
}

extension ExpandableSlideInteractionController: PopoverViewControllerDelegate {
    func popoverVC_scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let controller = UIView.controller(for: scrollView) else {
            return
        }
        let translation = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        if translation >= 0 {
            if controller.isBeingPresented { return }
            controller.view.transform = CGAffineTransform(translationX: 0, y: translation)
            
            if translation >= 25 {
                if !scrollView.isTracking && !scrollView.isDragging {
                    controller.dismiss(animated: true, completion: nil)
                    return
                }
            }
        } else {
            self.interactionAction?()
        }
    }
}



