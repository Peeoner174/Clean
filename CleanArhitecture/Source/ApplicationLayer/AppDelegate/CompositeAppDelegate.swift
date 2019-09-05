//
//  CompositeAppDelegate.swift
//  CleanArhitecture
//
//  Created by MSI on 01/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

typealias AppDelegateType = UIResponder & UIApplicationDelegate

class CompositeAppDelegate: AppDelegateType {
    private let appDelegates: [AppDelegateType]
    
    init(appDelegates: [AppDelegateType]) {
        self.appDelegates = appDelegates
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        appDelegates.forEach { _ = $0.application?(application, didFinishLaunchingWithOptions: launchOptions) }
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        appDelegates.forEach { $0.applicationWillEnterForeground?(application) }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        appDelegates.forEach { $0.applicationDidBecomeActive?(application) }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        appDelegates.forEach { $0.applicationWillResignActive?(application) }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        appDelegates.forEach { _ = $0.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken) }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        appDelegates.forEach { $0.application?(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler) }
    }
    
}
