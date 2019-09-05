//
//  AppDelegateFactory.swift
//  CleanArhitecture
//
//  Created by MSI on 01/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

enum AppDelegateFactory {
    static func makeDefault(_ window: UIWindow?) -> AppDelegateType {
        return CompositeAppDelegate(appDelegates: [StartupConfiguratorAppDelegate(window: window)] )
    }
}
