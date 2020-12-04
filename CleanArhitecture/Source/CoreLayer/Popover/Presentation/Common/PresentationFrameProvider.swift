//
//  PresentationFrameProvider.swift
//  CleanArhitecture
//
//  Created by Pavel Kochenda on 13.11.2020.
//  Copyright © 2020 IA. All rights reserved.
//

import UIKit

// MARK: - PresentationFrameProvider

typealias FrameOfPresentedViewClosure = ((_ containerViewFrame: CGRect) throws -> CGRect)?

protocol PresentationFrameProvider {
    var frameOfPresentedViewClosure: FrameOfPresentedViewClosure { get set }
}

// MARK: - PresentationExpandableFrameProvider

typealias FrameOfExpandablePresentedViewClosure = ((_ containerViewFrame: CGRect, _ expandStep: UInt8) throws -> CGRect)?

typealias OnMakeStepClosure = ((_ isMaked: Bool) -> Void)

typealias MakeExpandStepClosure = ((_ containerViewFrame: CGRect, _ expandStep: UInt8, _ onMakeStepClosure: OnMakeStepClosure) throws -> CGRect)?


struct ExpandablePopoverFrameMeta {
    var tweakExpandableFrameCommands: [TweakPopoverCommand]
    var expandSteps: [CGRect] = []
    var currentExpandStep: UInt8 = 0
    var blockDismissOnPanGesture: Bool = true
    
    internal init(
        expandSteps: [CGRect] = [],
        currentExpandStep: UInt8 = 0,
        blockDismissOnPanGesture: Bool = true,
        tweakExpandableFrameCommands: [TweakPopoverCommand] = []
    ) {
        self.expandSteps = expandSteps
        self.currentExpandStep = currentExpandStep
        self.blockDismissOnPanGesture = blockDismissOnPanGesture
        self.tweakExpandableFrameCommands = tweakExpandableFrameCommands
    }
}

protocol PresentationExpandableFrameProvider: class {
    var expandablePopoverFrameMeta: ExpandablePopoverFrameMeta { get set }
    var frameOfExpandablePresentedViewClosure: FrameOfExpandablePresentedViewClosure { get set }
    func getMaximumExpandFrameHeight(forContainerView containerView: UIView) -> CGFloat
}
