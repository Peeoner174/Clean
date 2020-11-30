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
        
        let presentation = ExpandableSlidePresentation(
            timing: PresentationTiming(
                duration: .normal,
                presentationCurve: .easeInOut,
                dismissCurve: .easeInOut
            ),
            direction: .bottom,
            uiConfiguration: PresentationUIConfiguration()
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
    
    @IBAction func openMapKitViewController(_ sender: Any) {
        let vc = MapKitViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true, completion: {
            vc.showPopOver()
        })
    }
}

extension UINavigationController {
    public func pushViewController(
        _ viewController: UIViewController,
        animated: Bool,
        completion: @escaping () -> Void)
    {
        pushViewController(viewController, animated: animated)

        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }

        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }

    func popViewController(
        animated: Bool,
        completion: @escaping () -> Void)
    {
        popViewController(animated: animated)

        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }

        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }
}
