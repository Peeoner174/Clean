//
//  MapKitViewController.swift
//  CleanArhitecture
//
//  Created by MSI on 25.11.2020.
//  Copyright © 2020 IA. All rights reserved.
//

import UIKit
import MapKit

class MapKitViewController: UIViewController {
    
//    @IBOutlet weak var mapKitView: MKMapView!
    
    var presentedVC = EmployeeListViewController.instantiate()
    
    func showPopOver() {
    
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
        PopoverManager.presentExpandableSlidePopover(vc: presentedVC, in: self, presentation: presentation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
