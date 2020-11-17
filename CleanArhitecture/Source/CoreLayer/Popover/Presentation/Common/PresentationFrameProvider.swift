//
//  PresentationFrameProvider.swift
//  CleanArhitecture
//
//  Created by Pavel Kochenda on 13.11.2020.
//  Copyright © 2020 IA. All rights reserved.
//

import UIKit

typealias FrameOfPresentedViewClosure = ((_ containerViewFrame: CGRect) throws -> CGRect)?

protocol PresentationFrameProvider {
    var frameOfPresentedViewClosure: FrameOfPresentedViewClosure { get set }
}

typealias FrameOfExpandablePresentedViewClosure = ((_ containerViewFrame: CGRect, _ expandStep: UInt8) throws -> CGRect)?

protocol PresentationExpandableFrameProvider {
    var expandStep: UInt8 { get set }
    var frameOfExpandablePresentedViewClosure: FrameOfExpandablePresentedViewClosure { get set }
}
