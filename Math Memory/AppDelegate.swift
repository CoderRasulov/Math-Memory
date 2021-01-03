//
//  AppDelegate.swift
//  Math Memory
//
//  Created by Asliddin Rasulov on 2/13/20.
//  Copyright © 2020 Asliddin Rasulov. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UserDefaults.standard.set(false, forKey: "voice")
        // Override point for customization after application launch.
        return true
    }
}

