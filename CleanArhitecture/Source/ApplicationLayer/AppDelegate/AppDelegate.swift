//
//  AppDelegate.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var appDelegate = AppDelegateFactory.makeDefault(self.window)
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        _ = appDelegate.application?(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        appDelegate.applicationWillEnterForeground?(application)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        appDelegate.applicationDidBecomeActive?(application)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        appDelegate.applicationWillResignActive?(application)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        appDelegate.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        appDelegate.application?(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
    }
    
}

