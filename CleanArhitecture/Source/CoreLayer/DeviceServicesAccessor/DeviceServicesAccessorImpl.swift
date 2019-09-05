//
//  MediaAccessorImpl.swift
//  CleanArhitecture
//
//  Created by MSI on 05/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import Foundation
import UIKit

final class DeviceServicesAccessorImpl: NSObject, DeviceServicesAccessor {
    
    weak var delegate: DeviceServicesAccessorDelegate?
    
    func openCamera(from viewController: UIViewController) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            return
        }
        
        let imagePicker  = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        viewController.present(imagePicker, animated: true)
    }
    
    func openImageGallery(from viewController: UIViewController) {
        let imagePicker  = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        viewController.present(imagePicker, animated: true)
    }
    
}

extension DeviceServicesAccessorImpl: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
}

