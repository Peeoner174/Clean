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
            
        let t = PresentationUIConfiguration(cornerRadius: 15, backgroundStyle: .dimmed(maxAlpha: 0.7, minAlpha: 0.1), isTapBackgroundToDismissEnabled: true, corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner])
        
        let presentation = ExpandableSlidePresentation(direction: .bottom, uiConfiguration: t) { (containerViewFrame, presentStep) -> CGRect in
            
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
    
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
    }
}
