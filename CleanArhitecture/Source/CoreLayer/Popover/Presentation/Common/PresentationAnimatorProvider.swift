//
//  PresentationAnimatorProvider.swift
//  CleanArhitecture
//
//  Created by MSI on 06/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

protocol PresentationAnimatorProvider {
    var showAnimator: UIViewControllerAnimatedTransitioning { get }
    var dismissAnimator: UIViewControllerAnimatedTransitioning { get }
}
