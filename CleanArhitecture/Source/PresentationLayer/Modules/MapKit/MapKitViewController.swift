//
//  MapKitViewController.swift
//  CleanArhitecture
//
//  Created by MSI on 25.11.2020.
//  Copyright © 2020 IA. All rights reserved.
//

import UIKit
import MapKit

protocol ViewControllerLifecycler: UIViewController {
    var viewWillDisappearHandler: EmptyCompletion { get set }
}

class MapKitViewController: UIViewController {
    
    var viewWillDisappearHandler: EmptyCompletion = nil
    
    func showPopOver() {
        let presentedVC = EmployeeListViewController.instantiate()
        
        let presentation = ExpandableSlidePresentation(
            timing: PresentationTiming(
                duration: .normal,
                presentationCurve: .easeInOut,
                dismissCurve: .easeInOut
            ),
            direction: .bottom,
            uiConfiguration: PresentationUIConfiguration(backgroundStyle: .clear(shouldPassthrough: true))
        ) { (containerViewFrame, presentStep) -> CGRect in
            
            switch presentStep {
            case 0:
                return CGRect(x: 0.0, y: UIScreen.main.bounds.height - 400, width: UIScreen.main.bounds.width, height: 400)
            case 1:
                return CGRect(x: 0.0, y: UIScreen.main.bounds.height - 550, width: UIScreen.main.bounds.width, height: 550)
            case 2... :
                throw LiveUpdateError.reachedExpandMaximum
            default:
                throw LiveUpdateError.undefinedExpandStep
            }
        }
        
        self.viewWillDisappearHandler = {
            presentedVC.dismiss(animated: true, completion: nil)
        }
        
        PopoverManager.presentExpandablePopoverWithActiveParent(
            vc: presentedVC,
            in: self,
            animated: true,
            presentation: presentation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.viewWillDisappearHandler?()
    }
}


