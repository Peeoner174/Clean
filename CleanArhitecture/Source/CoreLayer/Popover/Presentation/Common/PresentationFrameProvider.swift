//
//  PresentationFrameProvider.swift
//  CleanArhitecture
//
//  Created by Pavel Kochenda on 13.11.2020.
//  Copyright © 2020 IA. All rights reserved.
//

import UIKit

typealias FrameOfPresentedViewClosure = ((_ containerViewFrame: CGRect) -> CGRect)?

protocol PresentationFrameProvider {
    var frameOfPresentedViewClosure: FrameOfPresentedViewClosure { get set }
}

typealias FrameOfExpandablePresentedViewClosure = ((_ containerViewFrame: CGRect, _ expandStep: Int8) -> CGRect)?

protocol PresentationExpandableFrameProvider {
    var expandStep: Int8 { get set }
    var frameOfExpandablePresentedViewClosure: FrameOfExpandablePresentedViewClosure { get set }
}
