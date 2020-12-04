//
//  PopoverManager.swift
//  CleanArhitecture
//
//  Created by MSI on 08/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

class PopoverManager {
    
    static func presentExpandableSlidePopover(vc presentedVC: ExpandablePopoverViewController,
                        in presentingVC: UIViewController,
                        animated: Bool = true,
                        presentation: ExpandableSlidePresentation,
                        presentCompletion: EmptyCompletion = nil,
                        dismissCompletion: EmptyCompletion = nil) {
        
        let popOverPresentationDelegate = PopoverPresentationDelegateImpl(
            presentation: presentation,
            dismissCompletion: dismissCompletion
        )
        
        let presentationController = PopoverPresentationController(
            presentedVС: presentedVC,
            presentingVC: presentingVC,
            presentation: presentation,
            delegate: popOverPresentationDelegate
        )
        
        let presentInteractionController = ExpandableSlideInteractionController(
            presentedViewController: presentedVC,
            presentationController: presentationController,
            transitionType: .presentation
        )
        
        let dismissInteractionController = SlideInteractionController(
            presentedViewController: presentedVC,
            presentationController: presentationController,
            transitionType: .dismissal
        )
        
        presentedVC.scrollViewObserver = presentInteractionController
        
        popOverPresentationDelegate.presentationController = presentationController
        popOverPresentationDelegate.presentInteractionController = presentInteractionController
        popOverPresentationDelegate.dismissInteractionController = dismissInteractionController
        popOverPresentationDelegate.prepare(presentedViewController: presentedVC)
        
        presentingVC.present(presentedVC, animated: animated, completion: presentCompletion)
    }
    
    
    static func presentExpandablePopoverWithActiveParent(
        vc presentedVC: ExpandablePopoverViewController,
        in presentingVC: UIViewController,
        animated: Bool = true,
        presentation: ExpandableSlidePresentation,
        presentCompletion: EmptyCompletion = nil,
        dismissCompletion: EmptyCompletion = nil
    ) {
        
        let popOverPresentationDelegate = PopoverPresentationDelegateImpl(
            presentation: presentation,
            dismissCompletion: dismissCompletion
        )
        
        let presentationController = PopoverPresentationController(
            presentedVС: presentedVC,
            presentingVC: presentingVC,
            presentation: presentation,
            delegate: popOverPresentationDelegate
        )
        
        let presentInteractionController = ExpandableSlideInteractionController(
            presentedViewController: presentedVC,
            presentationController: presentationController,
            transitionType: .presentation
        )
        
        let dismissInteractionController = SlideInteractionController(
            presentedViewController: presentedVC,
            presentationController: presentationController,
            transitionType: .dismissal
        )
        
        presentedVC.scrollViewObserver = presentInteractionController
        
        popOverPresentationDelegate.presentationController = presentationController
        popOverPresentationDelegate.presentInteractionController = presentInteractionController
        popOverPresentationDelegate.dismissInteractionController = dismissInteractionController
        popOverPresentationDelegate.prepare(presentedViewController: presentedVC)
        
        presentingVC.present(presentedVC, animated: animated, completion: presentCompletion)
    }
}
