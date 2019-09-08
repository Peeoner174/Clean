//
//  PresentationUIConfiguration.swift
//  CleanArhitecture
//
//  Created by MSI on 06/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit
import Foundation

public struct PresentationUIConfiguration {
    public var cornerRadius: CGFloat
    public var backgroundStyle: BackgroundStyle
    public var isTapBackgroundToDismissEnabled: Bool
    public var corners: CACornerMask
    
    public init(cornerRadius: CGFloat = 0.0,
                backgroundStyle: BackgroundStyle = .dimmed(alpha: 0.5),
                isTapBackgroundToDismissEnabled: Bool = true,
                corners: CACornerMask = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]) {
        self.cornerRadius = cornerRadius
        self.backgroundStyle = backgroundStyle
        self.isTapBackgroundToDismissEnabled = isTapBackgroundToDismissEnabled
        self.corners = corners
    }
}
