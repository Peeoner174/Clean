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

protocol PopoverFrameTweaker {
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
        case .blurred(effectStyle: let effectStyle, maxAlpha: let maxAlpha, minAlpha: let minAlpha):
            var blurredView = BluredView(effectStyle: effectStyle, maxAlpha: maxAlpha, minAlpha: minAlpha)
            self.changeBackgroundViewIntensity = { fullExpandPercent in
                blurredView.updateIntensity(percent: fullExpandPercent * (maxAlpha - minAlpha) + minAlpha)
            }
            view = blurredView
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
        let popoverContainerView: PopoverContainerView = {
            PopoverContainerViewBuilder()
                .add(node: presentingViewController.view)
                .add(optionalNode: dragIndicatorView)
                .build(withFrame: containerView?.frame ?? .zero)
        }()
        
//        let popoverContainerView = PopoverContainerView(
//            presentedView: presentedViewController.view,
//            frame: frame,
//            dragIndicatorView: dragIndicatorView
//        )
        return popoverContainerView
    }()
    
    override var presentedView: UIView {
        return popOverContainerView
    }
    
    private lazy var dragIndicatorView: UIView? = {
        (presentation as? PresentationDragIndicatorViewProvider)?.dragIndicatorView
    }()
    
    // MARK: - Initializers
    
    init(presentedVС: UIViewController, presentingVC: UIViewController?, presentation: Presentation, delegate: PopoverPresentationDelegate?) {
        self.presentation = presentation
        self.popOverPresentationDelegate = delegate
        super.init(presentedViewController: presentedVС, presenting: presentingVC)
        
        if let presentation = self.presentation as? PresentationExpandableFrameProvider {
            setExecuteHandlers(forCommands: presentation.expandablePopoverFrameMeta.tweakExpandableFrameCommands)
        }
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
            self.backgroundView.onPresent()
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
       
        /* For popOverContainerView frame correct update */
        if let frameProvider = self.presentation as? PresentationExpandableFrameProvider {
            let currentExpandStep = frameProvider.expandablePopoverFrameMeta.currentExpandStep
            if let frameCurrentExpandStep = try? frameProvider.frameOfExpandablePresentedViewClosure!(self.containerView!.frame, currentExpandStep) {
                self.popOverContainerView.frame = frameCurrentExpandStep
            }
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.allowUserInteraction, .beginFromCurrentState]) {
            self.containerView?.layoutIfNeeded()
            self.changeBackgroundViewIntensity?(self.presentedViewController.view.frame.height / self.getMaximumExpandFrameHeight())
        } completion: { (isTrue) in
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
        if
            let frameProvider = presentation as? PresentationExpandableFrameProvider,
            let currentStepFrame = expandSteps[guarded: frameProvider.expandablePopoverFrameMeta.currentExpandStep] {
            if needTweak {
                presentedViewController.view.frame = currentStepFrame
            } else {
                presentedView.frame = frameOfPresentedViewInContainerView
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

extension PopoverPresentationController: PopoverFrameTweaker {
    
    func tweakFrame(currentFrame: CGRect, duration: Duration, direction: Direction) throws {
        updateCurrentExpandStep(currentFrame: currentFrame, direction: direction)
        
        switch direction {
        case .bottom:
            var previousStepFrame: CGRect
            repeat {
                do {
                    previousStepFrame = try getNextStepFrame(panDirection: direction)
                } catch let error {
                    guard
                        let luError = error as? LiveUpdateError,
                        luError == .reachedExpandMinimum,
                        let presentation = presentation as? PresentationExpandableFrameProvider & Presentation,
                        presentation.expandablePopoverFrameMeta.blockDismissOnPanGesture
                    else { throw error }
                    break
                }
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
    
    private var expandSteps: [CGRect] {
        get {
            guard let presentation = presentation as? (PresentationExpandableFrameProvider & Presentation) else { return [] }
            var expandStepsFrame: [CGRect] = []
            do {
                for stepNumber in 0... {
                    let stepFrame = try presentation.frameOfExpandablePresentedViewClosure!(self.containerView!.frame, UInt8(stepNumber))
                    expandStepsFrame.append(stepFrame)
                }
            } catch {
                return expandStepsFrame
            }
            return expandStepsFrame
        }
    }
    
    private func updateCurrentExpandStep(currentFrame: CGRect, direction: Direction) {
        guard let presentation = presentation as? (PresentationExpandableFrameProvider & Presentation) else { return }
        
        switch direction {
        case .top:
            for stepNumber in stride(from: expandSteps.count - 1, through: 1, by: -1) {
                if currentFrame.height < expandSteps[stepNumber].height {
                    continue
                }
                presentation.expandablePopoverFrameMeta.currentExpandStep = stepNumber - 1 >= 0 ? UInt8(stepNumber - 1) : UInt8(0)
            }
        case .bottom:
            for stepNumber in 0...expandSteps.count - 1 {
                if currentFrame.height > expandSteps[stepNumber].height {
                    continue
                }
                presentation.expandablePopoverFrameMeta.currentExpandStep = UInt8(stepNumber)
            }
        default:
            break
        }
        self.presentation = presentation
    }
    
    func getNextStepFrame(panDirection: Direction) throws -> CGRect {
        guard let presentation = presentation as? (PresentationExpandableFrameProvider & Presentation) else {
            return presentedViewController.view.frame
        }
        
        let newFrame: CGRect
        switch panDirection {
        case .top:
            newFrame = try presentation.frameOfExpandablePresentedViewClosure!(
                containerView!.frame,
                presentation.expandablePopoverFrameMeta.currentExpandStep + 1
            )
            presentation.expandablePopoverFrameMeta.currentExpandStep += 1
        case .bottom:
            guard presentation.expandablePopoverFrameMeta.currentExpandStep != 0 else {
                throw LiveUpdateError.reachedExpandMinimum
            }
            newFrame = try presentation.frameOfExpandablePresentedViewClosure!(
                containerView!.frame,
                presentation.expandablePopoverFrameMeta.currentExpandStep - 1
            )
            presentation.expandablePopoverFrameMeta.currentExpandStep -= 1
        default:
            newFrame = presentedViewController.view.frame
        }
        self.presentation = presentation
        return newFrame
    }
    
    func setExecuteHandlers(forCommands commands: [TweakPopoverCommand]) {
        
        for index in 0 ..< commands.count {
            let command = commands[index]
            command.onCommandExecuteHandler = { [weak self, weak command] in
                guard
                    let self = self,
                    let command = command,
                    let presentationFrameProvider = self.presentation as? (PresentationExpandableFrameProvider & Presentation)
                else { return }
                presentationFrameProvider.expandablePopoverFrameMeta.currentExpandStep = command.step
                self.updatePresentation(presentation: presentationFrameProvider, duration: .normal)
            }
        }
    }
}
