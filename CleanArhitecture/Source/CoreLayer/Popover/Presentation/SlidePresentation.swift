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
    PresentationShowDirectionProvider

public struct SlidePresentation: SlidePresentationParamsProvider {
    public var presentationUIConfiguration: PresentationUIConfiguration
    public var showDirection: Direction
    public var presentationTiming: PresentationTiming
    
    public init(timing: PresentationTiming = PresentationTiming(), direction: Direction, uiConfiguration: PresentationUIConfiguration) {
        self.presentationTiming = timing
        self.showDirection = direction
        self.presentationUIConfiguration = uiConfiguration
    }
}

extension SlidePresentation: PresentationAnimatorProvider {
    public var showAnimator: UIViewControllerAnimatedTransitioning {
        return SlideAnimator(transitionType: .presentation, presentation: self)
    }
    
    public var dismissAnimator: UIViewControllerAnimatedTransitioning {
        return SlideAnimator(transitionType: .dismissal, presentation: self)
    }
}
