//
//  PopoverManager.swift
//  CleanArhitecture
//
//  Created by MSI on 08/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

class PopoverManager {
    static func presentSlidePopover(vc presentedVC: PopoverViewController,
                        in presentingVC: UIViewController,
                        animated: Bool = true,
                        presentation: SlidePresentation,
                        frameOfPresentedView: FrameOfPresentedViewClosure,
                        presentCompletion: EmptyCompletion = nil,
                        dismissCompletion: EmptyCompletion = nil) {
        
        let popOverPresentationDelegate = PopoverPresentationDelegateImpl(
            presentation: presentation,
            frameOfPresentedView: frameOfPresentedView,
            dismissCompletion: dismissCompletion
        )
        
        let presentationController = PopoverPresentationController(
            presentedVС: presentedVC,
            presentingVC: presentingVC,
            presentation: presentation,
            delegate: popOverPresentationDelegate
        )
        
        let presentInteractionController = SlideInteractionController(
            presentedViewController: presentedVC,
            presentationController: presentationController,
            transitionType: .presentation
        )
        
        let dismissInteractionController = ExpandableSlideInteractionController(
            presentedViewController: presentedVC,
            presentationController: presentationController,
            transitionType: .presentation,
            frameOfPresentedView: frameOfPresentedView
        )
        
        presentedVC.popoverDelegate = dismissInteractionController
        
        popOverPresentationDelegate.presentationController = presentationController
        popOverPresentationDelegate.presentInteractionController = presentInteractionController
        popOverPresentationDelegate.dismissInteractionController = dismissInteractionController
        
        popOverPresentationDelegate.prepare(presentedViewController: presentedVC)
        
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            presentingVC.present(presentedVC, animated: animated, completion: presentCompletion)
        }
    }
}
