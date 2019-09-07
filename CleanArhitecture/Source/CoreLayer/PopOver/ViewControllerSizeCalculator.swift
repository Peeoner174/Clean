//
//  ViewControllerSizeCalculator.swift
//  CleanArhitecture
//
//  Created by MSI on 08/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

class ViewControllerSizeCalculator {
    
    func getFrameOfPresentedViewInContainerView(containerView: UIView, presentation: Presentation, presentedViewController: UIViewController) -> CGRect {
        return CGRect(x: 0,y: 0,width: containerView.bounds.size.width, height: containerView.bounds.size.height)
    }

}
