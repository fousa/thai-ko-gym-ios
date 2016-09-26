//
//  AppDelegate.swift
//  Thai Ko Gym
//
//  Created by Jelle Vandebeeck on 17/09/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        BuddyBuildSDK.setup()

        setupAppearances()
        
        return true
    }

    // MARK: - Appearances

    private func setupAppearances() {
        UIBarButtonItem.appearance().tintColor = UIColor(red:0.24, green:0.77, blue:0.82, alpha:1.00)
    }
    
}

