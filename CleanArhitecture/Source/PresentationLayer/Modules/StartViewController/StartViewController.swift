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
        let presentation = SlidePresentation(direction: .bottom, uiConfiguration: PresentationUIConfiguration())
        
        PopoverManager.presentSlidePopover(
            vc: presentedVC,
            in: self,
            presentation: presentation,
            frameOfPresentedView: { containerViewFrame in
                return CGRect(origin: CGPoint(x: 0, y: 310), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height - 300))
        },
            presentCompletion: { print("present completion")},
            dismissCompletion: { print("dismiss completion")})
    }
    
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
          super.preferredContentSizeDidChange(forChildContentContainer: container)
          
      }
}
