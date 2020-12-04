//
//  PresentationTiming.swift
//  CleanArhitecture
//
//  Created by MSI on 06/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

struct PresentationTiming {
    var duration: Duration
    var presentationCurve: UIView.AnimationCurve
    var dismissCurve: UIView.AnimationCurve
    
    init(
        duration: Duration = .fast,
         presentationCurve: UIView.AnimationCurve = .linear,
         dismissCurve: UIView.AnimationCurve = .linear
    ) {
        self.duration = duration
        self.presentationCurve = presentationCurve
        self.dismissCurve = dismissCurve
    }
}
