//
//  ExpandableSlidePresentation.swift
//  CleanArhitecture
//
//  Created by Pavel Kochenda on 13.11.2020.
//  Copyright © 2020 IA. All rights reserved.
//

import Foundation
import UIKit

private typealias ExpandableSlidePresentationParamsProvider =
    PresentationTimingInformationProvider &
    PresentationUIConfigurationProvider &
    PresentationShowDirectionProvider &
    PresentationExpandableFrameProvider &
    PresentationDragIndicatorViewProvider

class ExpandableSlidePresentation: ExpandableSlidePresentationParamsProvider {
    var expandablePopoverFrameMeta: ExpandablePopoverFrameMeta
    var frameOfExpandablePresentedViewClosure: FrameOfExpandablePresentedViewClosure
    var presentationUIConfiguration: PresentationUIConfiguration
    var showDirection: Direction
    var presentationTiming: PresentationTiming
    weak var dragIndicatorView: UIView?
    
    init(
        timing: PresentationTiming = PresentationTiming(),
        direction: Direction,
        uiConfiguration: PresentationUIConfiguration,
        tweakExpandableFrameCommands: [TweakPopoverCommand] = [],
        dragIndicatorView: UIView? = nil,
        blockDismissOnPanGesture: Bool = true,
        frameOfExpandablePresentedViewClosure: FrameOfExpandablePresentedViewClosure
    ) {
        self.presentationTiming = timing
        self.showDirection = direction
        self.presentationUIConfiguration = uiConfiguration
        self.dragIndicatorView = dragIndicatorView
        self.frameOfExpandablePresentedViewClosure = frameOfExpandablePresentedViewClosure
        self.expandablePopoverFrameMeta = ExpandablePopoverFrameMeta(
            expandSteps: [],
            currentExpandStep: 0,
            blockDismissOnPanGesture: blockDismissOnPanGesture,
            tweakExpandableFrameCommands: tweakExpandableFrameCommands
        )
    }
    
    func getMaximumExpandFrameHeight(forContainerView containerView: UIView) -> CGFloat {
        var stepFrameHeight: CGFloat = 0
        do {
            for stepNumber in 0... {
                stepFrameHeight = try frameOfExpandablePresentedViewClosure!(containerView.frame, UInt8(stepNumber)).height
            }
        } catch {
            return stepFrameHeight
        }
        fatalError()
    }
    
    deinit {
        
    }
}

extension ExpandableSlidePresentation: PresentationAnimatorProvider {
    var showAnimator: UIViewControllerAnimatedTransitioning {
        return ExpandableSlideAnimator(transitionType: .presentation, presentation: self)
    }
    
    var dismissAnimator: UIViewControllerAnimatedTransitioning {
        return ExpandableSlideAnimator(transitionType: .dismissal, presentation: self)
    }
}
