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

struct ExpandablePopoverFrameMeta {
    let tweakExpandableFrameCommands: [TweakPopoverCommand]
    var expandSteps: [CGRect]
    var currentExpandStep: UInt8
}

protocol PresentationExpandableFrameProvider {
    var expandablePopoverFrameMeta: ExpandablePopoverFrameMeta { get set }
    var frameOfExpandablePresentedViewClosure: FrameOfExpandablePresentedViewClosure { get set }
    func getMaximumExpandFrameHeight(forContainerView containerView: UIView) -> CGFloat
}



