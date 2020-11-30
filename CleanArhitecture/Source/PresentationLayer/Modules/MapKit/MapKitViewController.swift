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
    
class MapKitViewController: UIViewController, ViewControllerLifecyclerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    var viewWillDisappearHandler: OnViewWillDissapearHandler? = nil
    
    var maxExpandPopoverCommand: TweakPopoverCommand = TweakPopoverCommand(step: 2)
    var minExpandPopoverCommand: TweakPopoverCommand = TweakPopoverCommand(step: 0)
    
    func showPopOver() {
        let presentedVC = EmployeeListViewController.instantiate()
        
        let presentation = ExpandableSlidePresentation(
            timing: PresentationTiming(
                duration: .normal,
                presentationCurve: .easeInOut,
                dismissCurve: .easeInOut
            ),
            direction: .bottom,
            uiConfiguration: PresentationUIConfiguration(backgroundStyle: .clear(shouldPassthrough: true)),
            tweakExpandableFrameCommands: [maxExpandPopoverCommand, minExpandPopoverCommand]
        ) { (containerViewFrame, presentStep) -> CGRect in
            
            switch presentStep {
            case 0:
                return CGRect(x: 0.0, y: UIScreen.main.bounds.height - 50, width: UIScreen.main.bounds.width, height: 50)
            case 1:
                return CGRect(x: 0.0, y: UIScreen.main.bounds.height - 300, width: UIScreen.main.bounds.width, height: 300)
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
        super.viewWillDisappear(animated)
    }
}

extension MapKitViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        self.maxExpandPopoverCommand.execute()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.minExpandPopoverCommand.execute()
        }
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
