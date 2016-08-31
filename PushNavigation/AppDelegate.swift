//
//  AppDelegate.swift
//  PsuhNot2
//
//  Created by development on 8/29/16.
//  Copyright © 2016 Tyro. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let tabBar = TabBar()
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        TabBar.printChildren()
        return true
    }
}








