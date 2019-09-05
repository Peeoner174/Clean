//
//  MediaAccessor.swift
//  CleanArhitecture
//
//  Created by MSI on 05/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import Foundation
import UIKit

protocol DeviceServicesAccessor: class {
    
    var delegate: DeviceServicesAccessorDelegate? { get set }
    
    func openCamera(from viewController: UIViewController)
    func openImageGallery(from viewController: UIViewController)
}

protocol DeviceServicesAccessorDelegate: class {
}
