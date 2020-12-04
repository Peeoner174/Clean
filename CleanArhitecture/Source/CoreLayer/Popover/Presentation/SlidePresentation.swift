//
//  SlidePresentation.swift
//  CleanArhitecture
//
//  Created by MSI on 06/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import Foundation
import UIKit

private typealias SlidePresentationParamsProvider =
    PresentationTimingInformationProvider &
    PresentationUIConfigurationProvider &
    PresentationShowDirectionProvider &
    PresentationFrameProvider

class SlidePresentation: SlidePresentationParamsProvider {
    var frameOfPresentedViewClosure: FrameOfPresentedViewClosure
    var presentationUIConfiguration: PresentationUIConfiguration
    var showDirection: Direction
    var presentationTiming: PresentationTiming
    
    init(
        timing: PresentationTiming = PresentationTiming(),
        direction: Direction,
        uiConfiguration: PresentationUIConfiguration,
        frameOfPresentedViewClosure: FrameOfPresentedViewClosure
    ) {
        self.presentationTiming = timing
        self.showDirection = direction
        self.presentationUIConfiguration = uiConfiguration
        self.frameOfPresentedViewClosure = frameOfPresentedViewClosure
    }
}

extension SlidePresentation: PresentationAnimatorProvider {
    var showAnimator: UIViewControllerAnimatedTransitioning {
        return SlideAnimator(transitionType: .presentation, presentation: self)
    }
    
    var dismissAnimator: UIViewControllerAnimatedTransitioning {
        return SlideAnimator(transitionType: .dismissal, presentation: self)
    }
}
