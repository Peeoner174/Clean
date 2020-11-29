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
    var changeBackgroundViewIntensity: BackgroundViewIntensityClosure { get set }
    func updatePresentation(presentation: Presentation, duration: Duration)
}

protocol PopoverFrameTweakable {
    func tweakFrame(currentFrame: CGRect, duration: Duration, direction: Direction) throws
    var needTweak: Bool { get set }
    func getMaximumExpandFrameHeight() -> CGFloat
}

typealias BackgroundViewIntensityClosure = ((_ percent: CGFloat) -> Void)?

final class PopoverPresentationController: UIPresentationController {
    private var presentation: Presentation
    private var popOverPresentationDelegate: PopoverPresentationDelegate?
    var needTweak: Bool = false
    
    // MARK: - Views
    
    private lazy var backgroundView: BackgroundDesignable = {
        let view: BackgroundDesignable
        switch self.presentation.presentationUIConfiguration.backgroundStyle {
        case .dimmed(maxAlpha: let maxDimAlpha, minAlpha: let minDimAlpha):
            var dimmedView = DimmedView(maxDimAlpha: maxDimAlpha, minDimAlpha: minDimAlpha)
            self.changeBackgroundViewIntensity = { fullExpandPercent in
                dimmedView.updateIntensity(percent: fullExpandPercent * (maxDimAlpha - minDimAlpha) + minDimAlpha)
            }
            view = dimmedView
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
    var changeBackgroundViewIntensity: BackgroundViewIntensityClosure = nil

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
            guard let self = self else {
                return
            }
            self.changeBackgroundViewIntensity?(self.presentedViewController.view.frame.height / self.getMaximumExpandFrameHeight())
            self.presentedViewController.setNeedsStatusBarAppearanceUpdate()
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
        self.needTweak = true
        
        UIView.animate(withDuration: duration.timeInterval, animations: {
            self.containerView?.layoutIfNeeded()
            self.changeBackgroundViewIntensity?(self.presentedViewController.view.frame.height / self.getMaximumExpandFrameHeight())
        }) { (isTrue) in
            self.needTweak = false
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
        if needTweak {
            if let presentation = presentation as? PresentationExpandableFrameProvider {
                presentedViewController.view.frame = try! presentation.frameOfExpandablePresentedViewClosure!(self.containerView!.frame, presentation.currentExpandStep)
            } else {
              presentedViewController.view.frame = frameOfPresentedViewInContainerView
            }
        } else {
            presentedView.frame = frameOfPresentedViewInContainerView
        }
        let corners = presentation.presentationUIConfiguration.corners
        let radius = presentation.presentationUIConfiguration.cornerRadius
        presentedViewController.view.roundCorners(corners, radius: radius)
    }
}

extension PopoverPresentationController: PopoverPresentationControllerProtocol {
    /**
     Do not require any other gesture recognizers to fail
     */
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }

    /**
     Allow simultaneous gesture recognizers only when the other gesture recognizer's view
     is the pan scrollable view
     */
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let presentedViewController = presentedViewController as? ExpandablePopoverViewController else {
            return false
        }
        return otherGestureRecognizer.view == presentedViewController.expandingScrollView
    }
}

extension PopoverPresentationController: PopoverFrameTweakable {
    
    func tweakFrame(currentFrame: CGRect, duration: Duration, direction: Direction) throws {
        updateCurrentExpandSteps(currentFrame: currentFrame, direction: direction)
        
        switch direction {
        case .bottom:
            var previousStepFrame: CGRect
            repeat {
                previousStepFrame = try getNextStepFrame(panDirection: direction)
            } while previousStepFrame.height > currentFrame.height
        case .top:
            var nextStepFrame: CGRect
            repeat {
                nextStepFrame = try getNextStepFrame(panDirection: direction)
            } while nextStepFrame.height < currentFrame.height
        default: break
        }
        self.updatePresentation(presentation: presentation, duration: duration)
    }
    
    func getMaximumExpandFrameHeight() -> CGFloat {
        if let presentation = self.presentation as? PresentationExpandableFrameProvider {
            return presentation.getMaximumExpandFrameHeight(forContainerView: self.containerView!)
        }
        fatalError("Unimplemented")
    }
    
    func updateCurrentExpandSteps(currentFrame: CGRect, direction: Direction) {
        guard var presentation = presentation as? (PresentationExpandableFrameProvider & Presentation) else { return }
        func getExpandStepsWithFramesDict() -> [CGRect] {
            if !presentation.expandSteps.isEmpty { return presentation.expandSteps }
            do {
                for stepNumber in 0... {
                    let stepFrame = try presentation.frameOfExpandablePresentedViewClosure!(containerView!.frame, UInt8(stepNumber))
                    presentation.expandSteps.append(stepFrame)
                }
                return presentation.expandSteps
            } catch {
                return presentation.expandSteps
            }
        }
        
        let expandsSteps = getExpandStepsWithFramesDict()
        
        switch direction {
        case .top:
            for stepNumber in stride(from: expandsSteps.count - 1, through: 1, by: -1) {
                if currentFrame.height < presentation.expandSteps[stepNumber].height {
                    continue
                }
                presentation.currentExpandStep = stepNumber - 1 >= 0 ? UInt8(stepNumber - 1) : UInt8(0)
            }
        case .bottom:
            for stepNumber in 0...presentation.expandSteps.count - 1 {
                if currentFrame.height > presentation.expandSteps[stepNumber].height {
                    continue
                }
                presentation.currentExpandStep = UInt8(stepNumber)
            }
        default:
            break
        }
        self.presentation = presentation
    }
    
    func getNextStepFrame(panDirection: Direction) throws -> CGRect {
        guard var presentation = presentation as? (PresentationExpandableFrameProvider & Presentation) else {
            return presentedViewController.view.frame
        }
        
        let newFrame: CGRect
        switch panDirection {
        case .top:
            newFrame = try presentation.frameOfExpandablePresentedViewClosure!(
                containerView!.frame,
                presentation.currentExpandStep + 1
            )
            presentation.currentExpandStep += 1
        case .bottom:
            guard presentation.currentExpandStep != 0 else {
                throw LiveUpdateError.reachedExpandMinimum
            }
            newFrame = try presentation.frameOfExpandablePresentedViewClosure!(
                containerView!.frame,
                presentation.currentExpandStep - 1
            )
            presentation.currentExpandStep -= 1
        default:
            newFrame = presentedViewController.view.frame
        }
        self.presentation = presentation
        return newFrame
    }
}
