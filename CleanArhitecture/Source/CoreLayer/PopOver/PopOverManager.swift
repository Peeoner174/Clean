//
//  PopOverManager.swift
//  CleanArhitecture
//
//  Created by MSI on 08/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

class PopOverManager {
    static func present(vc presentedVC: UIViewController,
                        in presentingVC: UIViewController,
                        presentation: Presentation,
                        frameOfPresentedView: FrameOfPresentedViewClosure) {
        
        let popOverPresentationDelegate = PopOverPresentationDelegateImpl(presentation: presentation, frameOfPresentedView: frameOfPresentedView)
        popOverPresentationDelegate.prepare(presentedViewController: presentedVC)
        
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            rootVC.present(presentedVC, animated: true, completion: nil)
        }
    }
}
