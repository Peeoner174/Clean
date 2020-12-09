//
//  BackgroundStyle.swift
//  CleanArhitecture
//
//  Created by MSI on 06/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

protocol BackgroundDesignable: UIView {
    var style: BackgroundStyle { get }
    var didTap: ((_ recognizer: UIGestureRecognizer) -> Void)? { get set }
    func onPresent()
    func onDissmis()
    func updateIntensity(percent: CGFloat)
}

extension BackgroundDesignable {
    func updateIntensity(percent: CGFloat) {}
    func onPresent() {}
}

enum BackgroundStyle {
    case dimmed(maxAlpha: CGFloat, minAlpha: CGFloat)
    case blurred(effectStyle: UIBlurEffect.Style, maxAlpha: CGFloat, minAlpha: CGFloat)
    case clear(shouldPassthrough: Bool)
}
