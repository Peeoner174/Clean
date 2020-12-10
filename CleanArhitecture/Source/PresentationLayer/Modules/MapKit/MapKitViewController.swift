//
//  MapKitViewController.swift
//  CleanArhitecture
//
//  Created by MSI on 25.11.2020.
//  Copyright © 2020 IA. All rights reserved.
//

import UIKit
import MapKit

typealias OnViewWillDissapearHandler = () -> ()

protocol ViewControllerLifecyclerDelegate: class {
    var viewWillDisappearHandler: OnViewWillDissapearHandler? { get set }
}
    
class MapKitViewController: UIViewController, ViewControllerLifecyclerDelegate, PopoverViewControllerFrameObserver {
    @IBOutlet weak var mapView: MKMapView!
    
    var onPopoverViewControllerChangeFrameHandler: ((CGRect) -> Void)?
    
    var viewWillDisappearHandler: OnViewWillDissapearHandler? = nil
    
    var maxExpandPopoverCommand: TweakPopoverCommand = TweakPopoverCommand(step: 1)
    var minExpandPopoverCommand: TweakPopoverCommand = TweakPopoverCommand(step: 0)
    
    func showPopOver() {
        let topConstraintedFrameHeight = self.navigationController!.navigationBar.frame.height + UIApplication.shared.windows[0].safeAreaInsets.top

        let presentedVC = EmployeeListViewController.instantiate()
        presentedVC.frameObserver = self
        
        onPopoverViewControllerChangeFrameHandler = { [weak self] in
            guard let self = self else { return }
            if $0.height > UIScreen.main.bounds.height - topConstraintedFrameHeight {
                UIView.animate(withDuration: 0.3) {
                    self.navigationController?.navigationBar.alpha = 1.0
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.navigationController?.navigationBar.alpha = 0.0
                }
            }
        }
        
        let presentation = ExpandableSlidePresentation(
            timing: PresentationTiming(
                duration: .normal,
                presentationCurve: .easeInOut,
                dismissCurve: .easeInOut
            ),
            direction: .bottom,
            uiConfiguration: PresentationUIConfiguration(backgroundStyle: .clear(shouldPassthrough: true)),
            tweakExpandableFrameCommands: [maxExpandPopoverCommand, minExpandPopoverCommand]
        ) { containerViewFrame, presentStep -> CGRect in
            switch presentStep {
            case 0:
                return CGRect(x: 0.0, y: containerViewFrame.height - 50, width: containerViewFrame.width, height: 50)
            case 1:
                return CGRect(x: 0.0, y: containerViewFrame.height - 300, width: containerViewFrame.width, height: 300)
            case 2:
                return CGRect(x: 0.0, y: containerViewFrame.height - 450, width: containerViewFrame.width, height: 450)
            case 3:
                return CGRect(x: 0.0, y: containerViewFrame.height - topConstraintedFrameHeight, width: containerViewFrame.width, height: containerViewFrame.height - topConstraintedFrameHeight)
            case 4... :
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
    
    deinit {
        self.viewWillDisappearHandler?()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

extension MapKitViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        self.minExpandPopoverCommand.execute()
    }
}

typealias onCommandExecuteHandler = EmptyCompletion 

class TweakPopoverCommand {
    var step: UInt8
    
    var onCommandExecuteHandler: EmptyCompletion = nil
    
    init(step: UInt8) {
        self.step = step
    }
    
    func execute() {
        onCommandExecuteHandler?()
    }
}

