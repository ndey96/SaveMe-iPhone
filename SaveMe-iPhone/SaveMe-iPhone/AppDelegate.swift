//
//  AppDelegate.swift
//  SaveMe
//
//  Created by Nolan Dey on 2016-01-09.
//  Copyright © 2016 Nolan Dey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    var mainVC : MainViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.mainVC = MainViewController()
        self.window?.rootViewController = UINavigationController(rootViewController: self.mainVC!)
        self.window?.makeKeyAndVisible()
        return true
    }
}

