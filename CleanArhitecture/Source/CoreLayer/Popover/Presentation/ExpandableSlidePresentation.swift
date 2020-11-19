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
    PresentationExpandableFrameProvider

struct ExpandableSlidePresentation: ExpandableSlidePresentationParamsProvider {
    var currentExpandStep: UInt8 = 0
    var expandSteps = [CGRect]()
    var frameOfExpandablePresentedViewClosure: FrameOfExpandablePresentedViewClosure
    var presentationUIConfiguration: PresentationUIConfiguration
    var showDirection: Direction
    var presentationTiming: PresentationTiming
    
    init(
        timing: PresentationTiming = PresentationTiming(),
        direction: Direction,
        uiConfiguration: PresentationUIConfiguration,
        frameOfExpandablePresentedViewClosure: FrameOfExpandablePresentedViewClosure
    ) {
        self.presentationTiming = timing
        self.showDirection = direction
        self.presentationUIConfiguration = uiConfiguration
        self.frameOfExpandablePresentedViewClosure = frameOfExpandablePresentedViewClosure
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
