//
//  AppDelegate.swift
//  Swift-RxSwift-MVVM-Demo
//
//  Created by Parth on 23/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        redirectToLaunchesList()
        decorateNavigationBarAppearance()
        return true
    }

    func redirectToLaunchesList(){
        let launchesListVC = LaunchesListVC()
        let navigationController = UINavigationController(rootViewController: launchesListVC)
        navigationController.navigationBar.isTranslucent = true
        navigationController.isNavigationBarHidden = false
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    func decorateNavigationBarAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor.ThemeColor.navigationBarTintColor
        UINavigationBar.appearance().tintColor = UIColor.ThemeColor.navigationTintColor
    }
}

