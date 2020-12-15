//
//  File.swift
//  CleanArhitecture
//
//  Created by Pavel Kochenda on 11.11.2020.
//  Copyright © 2020 IA. All rights reserved.
//

import UIKit

class ExpandableSlideInteractionController: UIPercentDrivenInteractiveTransition {
    weak private var presentedViewController: ExpandablePopoverViewController?
    weak private var presentationController: PopoverPresentationControllerProtocol?
    
    private let transitionType: TransitionType
    
    private lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(didPanOnPresentedView(_ :)))
        gesture.minimumNumberOfTouches = 1
        gesture.maximumNumberOfTouches = 1
        gesture.delegate = presentationController
        return gesture
    }()
    
    private var scrollViewScrollingObserver: NSKeyValueObservation?
    lazy var liveUpdateMeta: LiveUpdateMeta = {
        var liveUpdateMeta = LiveUpdateMeta()
        liveUpdateMeta.fullExpandedPresentedViewFrameHeight = (self.presentationController as! PopoverFrameTweaker).getMaximumExpandFrameHeight()
        return liveUpdateMeta
    }()
    
    init(presentedViewController: ExpandablePopoverViewController,
         presentationController: PopoverPresentationControllerProtocol,
         transitionType: TransitionType
    ) {
        
        self.presentedViewController = presentedViewController
        self.presentationController = presentationController
        self.transitionType = transitionType
        
        super.init()
    }
    
    deinit {
        scrollViewScrollingObserver?.invalidate()
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
        liveUpdateMeta.update(recognizer, presentedViewController: self.presentedViewController!)
        
        switch recognizer.state {
        case .began: break
        case .changed:
            guard
                (!liveUpdateMeta.presentedViewIsFullExpanded) ||
                (liveUpdateMeta.scrollViewMeta.scrollViewYOffset < 1
                    && liveUpdateMeta.scrollViewMeta.scrollViewReachedTopOnPanBegan
                    && liveUpdateMeta.direction == .bottom)
            else { break }
            respond(to: recognizer)
        case .ended:
            guard !liveUpdateMeta.presentedViewIsFullExpanded else { break }
            do {
                try (presentationController as! PopoverFrameTweaker).tweakFrame(
                    currentFrame: presentedViewController!.view.frame,
                    duration: .medium,
                    direction: liveUpdateMeta.direction!
                )
            } catch let error {
                guard let error = error as? LiveUpdateError else {
                    return
                }
                self.liveUpdateMeta.currentLiveUpdateError = error
                switch error {
                case .reachedExpandMaximum:
                    break
                case .reachedExpandMinimum:
                    if self.liveUpdateMeta.scrollViewMeta.scrollViewYOffset < 1 {
                        self.presentedViewController?.dismiss(animated: true, completion: nil)
                    }
                default:
                    return
                }
            }
        default:
            break
        }
    }
    
    // MARK: - PresentedVC frame translation methods
    
    func adjustFrames(to displacement: CGPoint) {
        let yCoordinateClosure: () -> CGFloat = { [weak self] in
            guard let self = self else { return 0.0 }
            if UIScreen.main.bounds.size.height - displacement.y - self.liveUpdateMeta.fullExpandedPresentedViewFrameHeight! > 2 {
                return UIScreen.main.bounds.size.height - self.liveUpdateMeta.fullExpandedPresentedViewFrameHeight!
            } else {
                return displacement.y
            }
        }
        self.presentedViewController?.view.frame.origin.y = yCoordinateClosure()
        self.presentedViewController?.view.frame.size.height = UIScreen.main.bounds.size.height - self.presentedViewController!.view.frame.origin.y
        self.presentationController?.changeBackgroundViewIntensity?(self.presentedViewController!.view.frame.height / liveUpdateMeta.fullExpandedPresentedViewFrameHeight!)
    }
    
    func respond(to panGestureRecognizer: UIPanGestureRecognizer) {
        var yDisplacement = panGestureRecognizer.translation(in: presentedViewController?.view).y
        
        /* fix interactive animation bug on start dismiss gesture from full expand popover state */
        if yDisplacement > 0 && liveUpdateMeta.fullExpandedPresentedViewFrameHeight! - presentedViewController!.view.frame.height < 2 {
            yDisplacement = min(yDisplacement, 5)
        }
        
        /* Autobraking interaction effect */
        if liveUpdateMeta.fullExpandedPresentedViewFrameHeight! - presentedViewController!.view.frame.height < 25.0 {
            yDisplacement = atan(yDisplacement)
        }
        
        adjustFrames(to: CGPoint(x: 0, y: presentedViewController!.view.frame.origin.y + yDisplacement))
        panGestureRecognizer.setTranslation(.zero, in: presentedViewController!.view)
    }
    
    // MARK: - Observable scrollView methods
    
    func didPanOnScrollView(_ scrollView: UIScrollView, change: NSKeyValueObservedChange<CGPoint>) {
        guard
            let presentedViewController = self.presentedViewController,
            !presentedViewController.isBeingDismissed,
            !presentedViewController.isBeingPresented
            else { return }
        
        if scrollView.isScrolling {
            if !liveUpdateMeta.presentedViewIsFullExpanded {
                haltScrolling(scrollView)
            } else {
                trackScrolling(scrollView)
            }
        }
    }
    
    func haltScrolling(_ scrollView: UIScrollView) {
        scrollView.setContentOffset(CGPoint(x: 0, y: liveUpdateMeta.scrollViewMeta.scrollViewYOffset), animated: false)
        scrollView.showsVerticalScrollIndicator = false
    }
    
    func trackScrolling(_ scrollView: UIScrollView) {
        liveUpdateMeta.scrollViewMeta.scrollViewYOffset = max(scrollView.contentOffset.y, 0)
        if !(self.presentationController as? PopoverFrameTweaker)!.needTweak {
            scrollView.showsVerticalScrollIndicator = true
        }
    }
}

// MARK: - PopoverViewControllerDelegate

extension ExpandableSlideInteractionController: PopoverViewControllerScrollViewObserver {
    func observe(scrollView: UIScrollView?) {
        scrollViewScrollingObserver?.invalidate()
        scrollViewScrollingObserver = scrollView?.observe(\.contentOffset, options: .old) { [weak self] scrollView, change in
            guard let self = self else {
                return
            }
            self.liveUpdateMeta.scrollViewMeta.scrollViewReachedBottom = scrollView.contentSize.height < scrollView.contentOffset.y + self.presentedViewController!.view.frame.height
            self.didPanOnScrollView(scrollView, change: change)
        }
    }
}

