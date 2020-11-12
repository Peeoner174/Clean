//
//  RootWireframe.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

class RootWireframe {
    
    class func setupView<T: UIViewController>(ofType type: T.Type, with window: UIWindow) {
        let vc = type.self.instantiate()
        let navigationController = NavigationController(rootViewController: vc)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}
