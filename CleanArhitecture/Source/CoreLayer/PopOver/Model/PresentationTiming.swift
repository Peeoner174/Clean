//
//  PresentationTiming.swift
//  CleanArhitecture
//
//  Created by MSI on 06/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit
public struct PresentationTiming {
    public var duration: Duration
    public var presentationCurve: UIView.AnimationCurve
    public var dismissCurve: UIView.AnimationCurve
    
    public init(duration: Duration = .medium,
                presentationCurve: UIView.AnimationCurve = .linear,
                dismissCurve: UIView.AnimationCurve = .linear) {
        self.duration = duration
        self.presentationCurve = presentationCurve
        self.dismissCurve = dismissCurve
    }
}
