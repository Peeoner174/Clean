//
//  SlideAnimator.swift
//  CleanArhitecture
//
//  Created by MSI on 06/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import Foundation
import UIKit

final class SlideAnimator: NSObject {
    private let transitionType: TransitionType
    private let presentation: SlidePresentation
    private var currentPropertyAnimator: UIViewPropertyAnimator?
    
    init(transitionType: TransitionType, presentation: SlidePresentation) {
        self.transitionType = transitionType
        self.presentation = presentation
        super.init()
    }
}

extension SlideAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return presentation.presentationTiming.duration.timeInterval
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let propertyAnimator: UIViewPropertyAnimator?
        switch transitionType {
        case .presentation:
            propertyAnimator = createPresentationPropertyAnimator(using: transitionContext)
        case .dismissal:
            propertyAnimator = createDismissalPropertyAnimator(using: transitionContext)
        }
        
        if propertyAnimator != nil {
            self.currentPropertyAnimator = propertyAnimator
            propertyAnimator?.startAnimation()
        }
    }
    
    private func createDismissalPropertyAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewPropertyAnimator? {
        guard
            let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from)
            else { return nil }
        
        // Calls viewWillAppear and viewWillDisappear
        fromVC.beginAppearanceTransition(false, animated: true)
        toVC.beginAppearanceTransition(true, animated: true)
        
        let toViewFrame = transitionContext.finalFrame(for: toVC)
        let fromViewFrame = transitionContext.containerView.frame
        
        switch self.presentation.showDirection {
        case .left:
            break
        case .right:
            break
        case .top:
            break
        case .bottom:
            break
        }
        
        let propertyAnimator = UIViewPropertyAnimator(
            duration: presentation.presentationTiming.duration.timeInterval,
            curve: presentation.presentationTiming.presentationCurve
        )
        
        propertyAnimator.addAnimations {
            
        }
        
        propertyAnimator.addCompletion { animatedPosition in
            // Calls viewDidAppear and viewDidDisappear
            fromVC.endAppearanceTransition()
            toVC.endAppearanceTransition()
        }
        
        return propertyAnimator
    }
    
//    private func animateDismissal(transitionContext: UIViewControllerContextTransitioning) {
//        guard
//            let toVC = transitionContext.viewController(forKey: .to),
//            let fromVC = transitionContext.viewController(forKey: .from)
//            else { return }
//
//        // Calls viewWillAppear and viewWillDisappear
//        fromVC.beginAppearanceTransition(false, animated: true)
//        toVC.beginAppearanceTransition(true, animated: true)
//
//      //  let presentable = panModalLayoutType(from: transitionContext)
//        let panView: UIView = transitionContext.containerView.panContainerView ?? fromVC.view
//
////        PanModalAnimator.animate({
////            panView.frame.origin.y = transitionContext.containerView.frame.height
////        }, config: presentable) { didComplete in
////            fromVC.view.removeFromSuperview()
////            // Calls viewDidAppear and viewDidDisappear
////            fromVC.endAppearanceTransition()
////            toVC.endAppearanceTransition()
////            transitionContext.completeTransition(didComplete)
////        }
 //   }
    
    private func createPresentationPropertyAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewPropertyAnimator? {
        guard
            let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from)
            else { return nil }
        
        // Calls viewWillAppear and viewWillDisappear
        fromVC.beginAppearanceTransition(false, animated: true)
        toVC.beginAppearanceTransition(true, animated: true)
        
        let toViewFrame = transitionContext.finalFrame(for: toVC)
        let fromViewFrame = transitionContext.containerView.frame
        
        switch self.presentation.showDirection {
        case .left:
            break
        case .right:
            break
        case .top:
            break
        case .bottom:
            break
        }
        
        let propertyAnimator = UIViewPropertyAnimator(
            duration: presentation.presentationTiming.duration.timeInterval,
            curve: presentation.presentationTiming.presentationCurve
        )
        
        propertyAnimator.addAnimations {
            
        }
        
        propertyAnimator.addCompletion { animatedPosition in
            // Calls viewDidAppear and viewDidDisappear
            fromVC.endAppearanceTransition()
            toVC.endAppearanceTransition()
        }
        
        return propertyAnimator
    }
    
//    private func animatePresentation(transitionContext: UIViewControllerContextTransitioning) {
//        guard
//            let toVC = transitionContext.viewController(forKey: .to),
//            let fromVC = transitionContext.viewController(forKey: .from)
//            else { return }
//
//    //    let presentable = panModalLayoutType(from: transitionContext)
//
//        // Calls viewWillAppear and viewWillDisappear
//        fromVC.beginAppearanceTransition(false, animated: true)
//        toVC.beginAppearanceTransition(true, animated: true)
//
//        let presentedViewFrame = transitionContext.finalFrame(for: toVC)
//        let presentingViewFrame = transitionContext.containerView.frame
//
//        switch self.presentation.showDirection {
//        case .left:
//            break
//        case .right:
//            break
//        case .top:
//            break
//        case .bottom:
//            break
//        }
//
//        // Use panView as presentingView if it already exists within the containerView
//        let panView: UIView = transitionContext.containerView.panContainerView ?? toVC.view
//
//        // Move presented view offscreen (from the bottom)
//        panView.frame = transitionContext.finalFrame(for: toVC)
//        panView.frame.origin.y = transitionContext.containerView.frame.height

        // Haptic feedback
//        if presentable?.isHapticFeedbackEnabled == true {
//            feedbackGenerator?.selectionChanged()
//        }
//
//        PanModalAnimator.animate({
//            panView.frame.origin.y = yPos
//        }, config: presentable) { [weak self] didComplete in
//            // Calls viewDidAppear and viewDidDisappear
//            fromVC.endAppearanceTransition()
//            toVC.endAppearanceTransition()
//            transitionContext.completeTransition(didComplete)
//            self?.feedbackGenerator = nil
//        }
 //   }

    
}
