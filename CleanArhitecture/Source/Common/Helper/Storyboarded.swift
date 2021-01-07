//
//  Storyboarded.swift
//  CleanArhitecture
//
//  Created by MSI on 01/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

protocol Storyboarded { }

extension Storyboarded where Self: UIViewController {

    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: self.reuseIdentifier, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: self.reuseIdentifier) as! Self
    }
}

extension UIViewController: Storyboarded {}
