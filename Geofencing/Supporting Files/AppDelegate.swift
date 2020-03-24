//
//  AppDelegate.swift
//  Geofencing
//
//  Created by Krešimir Baković on 24/03/2020.
//  Copyright © 2020 Codable Studio. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let newWindow = UIWindow(frame: UIScreen.main.bounds)
        self.window = newWindow
        Coordinator.shared.start(newWindow)
        self.window?.makeKeyAndVisible()
        return true
    }
}
