//
//  UISCrollView + isScrolling.swift
//  CleanArhitecture
//
//  Created by Pavel Kochenda on 19.11.2020.
//  Copyright © 2020 IA. All rights reserved.
//

import UIKit

extension UIScrollView {
    var isScrolling: Bool {
        return isDragging || !isDecelerating || isTracking
    }
}
