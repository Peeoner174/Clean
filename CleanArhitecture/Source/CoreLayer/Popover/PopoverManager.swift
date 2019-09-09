//
//  PopoverManager.swift
//  CleanArhitecture
//
//  Created by MSI on 08/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

class PopoverManager {

    static func present(vc presentedVC: UIViewController,
                        in presentingVC: UIViewController,
                        animated: Bool = true,
                        presentation: Presentation,
                        frameOfPresentedView: FrameOfPresentedViewClosure,
                        presentCompletion: EmptyCompletion = nil,
                        dismissCompletion: EmptyCompletion = nil) {
        
        let popOverPresentationDelegate = PopOverPresentationDelegateImpl(
            presentation: presentation,
            frameOfPresentedView: frameOfPresentedView,
            dismissCompletion: dismissCompletion
        )
        
        let presentationController = PopOverPresentationController(
            presentedVС: presentedVC,
            presentingVC: presentingVC,
            presentation: presentation,
            delegate: popOverPresentationDelegate
        )
        
        let presentInteractionController = InteractionController(
            presentedViewController: presentedVC,
            presentationController: presentationController,
            transitionType: .presentation
        )
        
        let dismissInteractionController = InteractionController(
            presentedViewController: presentedVC,
            presentationController: presentationController,
            transitionType: .dismissal
        )
        
        popOverPresentationDelegate.presentationController = presentationController
        popOverPresentationDelegate.presentInteractionController = presentInteractionController
        popOverPresentationDelegate.dismissInteractionController = dismissInteractionController
        
        popOverPresentationDelegate.prepare(presentedViewController: presentedVC)
        
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            rootVC.present(presentedVC, animated: animated, completion: presentCompletion)
        }
    }
    
}
