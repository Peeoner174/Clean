//
//  UIViewController + Lifecycle.swift
//  CleanArhitecture
//
//  Created by Pavel Kochenda on 29.11.2020.
//  Copyright © 2020 IA. All rights reserved.
//

import UIKit

extension UIViewController {
    @objc var isAboutToClose: Bool {
        return self.isBeingDismissed ||
            self.isMovingFromParent ||
            self.navigationController?.isBeingDismissed ?? false
    }
}
