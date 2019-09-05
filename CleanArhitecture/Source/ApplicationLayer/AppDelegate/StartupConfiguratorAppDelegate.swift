//
//  StartupConfiguratorAppDelegate.swift
//  CleanArhitecture
//
//  Created by MSI on 01/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

class StartupConfiguratorAppDelegate: AppDelegateType {
    
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        installRootViewControllerIntoWindow()
        return true
    }
    
    // MARK: - Private methods
    private func installRootViewControllerIntoWindow() {
        guard let window = window else { return }
        RootWireframe.setupView(ofType: Constants.startVCType, with: window)
    }
    
}
