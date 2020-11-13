//
//  StartViewController.swift
//  CleanArhitecture
//
//  Created by MSI on 12.11.2020.
//  Copyright © 2020 IA. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openEmployListViewController(_ sender: Any) {
        let presentedVC = EmployeeListViewController.instantiate()
        let presentation = ExpandableSlidePresentation(direction: .bottom, uiConfiguration: PresentationUIConfiguration()) { (containerViewFrame, presentStep) -> CGRect in
            switch presentStep {
            case 0:
                return CGRect(x: 0.0, y: 400, width: 375, height: 800)
            case 1:
                return CGRect(x: 0.0, y: 0, width: 375.0, height: 800)
            default: fatalError()
            }
        }
        PopoverManager.presentExpandableSlidePopover(vc: presentedVC, in: self, presentation: presentation)
    }
    
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
    }
}
