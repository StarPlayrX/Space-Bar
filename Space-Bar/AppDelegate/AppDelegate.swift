//
//  AppDelegate.swift
//  Space Bar
//
//  Created by Todd Bruss on 2/5/18.
//  Copyright © 2018 Todd Bruss. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let appSettings = AppSettings()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 1.5)
        Global.shared.levels = Global.shared.levels.reversed()
        Global.shared.rotation = Global.shared.rotation.reversed()

       /* #if targetEnvironment(macCatalyst)
        /* some margin */
        UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.forEach { windowScene in
            windowScene.titlebar?.titleVisibility = .hidden
            let height = (windowScene.screen.nativeBounds.height - 72) / 2
            let width = (0.5 * height) + 72
            windowScene.sizeRestrictions?.minimumSize = CGSize(width: width, height: height)
            windowScene.sizeRestrictions?.maximumSize = CGSize(width: width, height: height)
        }
        #endif*/
    
        appSettings.loadUserDefaults()
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        [UIInterfaceOrientationMask.portrait,UIInterfaceOrientationMask.portraitUpsideDown]
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        appSettings.saveUserDefaults()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        appSettings.saveUserDefaults()
    }
    
    
}

