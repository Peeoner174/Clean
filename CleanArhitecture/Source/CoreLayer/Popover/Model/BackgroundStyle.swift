//
//  BackgroundStyle.swift
//  CleanArhitecture
//
//  Created by MSI on 06/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

public protocol BackgroundDesignable: UIView {
    var style: BackgroundStyle { get }
    var didTap: ((_ recognizer: UIGestureRecognizer) -> Void)? { get set }
    func onPresent()
    func onDissmis()
}

public enum BackgroundStyle {
    case dimmed(alpha: CGFloat)
    case blurred(effectStyle: UIBlurEffect.Style)
    case clear(shouldPassthrough: Bool)
}
