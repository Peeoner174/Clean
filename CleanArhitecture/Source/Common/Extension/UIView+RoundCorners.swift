//
//  UIView+Extension.swift
//  CleanArhitecture
//
//  Created by MSI on 07/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(_ corners: [UIRectCorner], radius: CGFloat) {
        guard radius != 0.0 else {
            return
        }
        var cornerMasks = [CACornerMask]()
        corners.forEach { corner in
            cornerMasks.append(CACornerMask(rawValue: corner.rawValue))
        }
        
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = CACornerMask(cornerMasks)
    }
}
