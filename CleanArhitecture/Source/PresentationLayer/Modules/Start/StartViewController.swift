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
                return CGRect(x: 0.0, y: containerViewFrame.height - 400, width: containerViewFrame.width, height: 400)
            case 1:
                return CGRect(x: 0.0, y: containerViewFrame.height - 550, width: containerViewFrame.width, height: 550)
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
    
    @IBAction func openTripAdressesViewController(_ sender: Any) {
        let presentedVC = TripAdressesViewController.instantiate()
        
        let presentation = ExpandableSlidePresentation(
            timing: PresentationTiming(
                duration: .normal,
                presentationCurve: .easeInOut,
                dismissCurve: .easeInOut
            ),
            direction: .bottom,
            uiConfiguration: PresentationUIConfiguration(),
            dragIndicatorView: DragIndicatorView(frame: .zero),
            blockDismissOnPanGesture: false) { [unowned presentedVC] (containerViewFrame, presentStep) -> CGRect in
            
            switch presentStep {
            case 0:
                return CGRect(x: 0.0, y: containerViewFrame.height - presentedVC.tableViewHeight, width: containerViewFrame.width, height: presentedVC.tableViewHeight)
            case 1...:
                throw LiveUpdateError.reachedExpandMaximum
            default:
                throw LiveUpdateError.undefinedExpandStep
            }
        }
        
        PopoverManager.presentExpandableSlidePopover(vc: presentedVC, in: self, presentation: presentation)
    }
}

extension UINavigationController {
    func pushViewController(
        _ viewController: UIViewController,
        animated: Bool,
        completion: @escaping () -> Void)
    {
        pushViewController(viewController, animated: animated)

        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }

        coordinator.animate(alongsideTransition: nil) { context in
//            let command = RecursiveCheckExpressionCommand()
            /* if isInteractive == true in animate completion => custom presentation style will not be work. Then pushVC completion should be executed after coordinator dealloc */
            if context.isInteractive {
//                command.execute(onExpressionIsTrue: { [weak self] in
//                    guard let _ = self?.transitionCoordinator else {
//                        return true
//                    }
//                    return false
//                },
//                checkedDelayStep: 0.1, completion)
            } else {
                completion()
            }
        }
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

class RecursiveCheckExpressionCommand {
    
    func execute(onExpressionIsTrue isTrue: @escaping () -> Bool, checkedDelayStep delay: TimeInterval, _ block: @escaping () -> Void) {
        let delayTime = DispatchTime.now() + delay
        let dispatchWorkItem = isTrue() ? DispatchWorkItem(block: block) : DispatchWorkItem(block: {
            let command = RecursiveCheckExpressionCommand()
            command.execute(onExpressionIsTrue: isTrue, checkedDelayStep: delay, block)
        });
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: dispatchWorkItem)
    }
}
