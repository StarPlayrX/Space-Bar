//
//  AppDelegate.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/21/22.
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let appSettings = AppSettings()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        appSettings.loadUserDefaults()
        
        
        let screenDensity = UIScreen().getScale
        
          #if targetEnvironment(macCatalyst)
          UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.forEach { windowScene in
              windowScene.titlebar?.titleVisibility = .hidden
              yCoverMacOS = 32
              
              if screenDensity == 1.0 {
                  heightMacOS = windowScene.screen.bounds.height * 2 - 150
                  widthMacOS = heightMacOS / 2
                  windowScene.sizeRestrictions?.minimumSize = CGSize(width: widthMacOS, height: heightMacOS)
                  windowScene.sizeRestrictions?.maximumSize = CGSize(width: widthMacOS, height: heightMacOS)
              } else {
                  heightMacOS = windowScene.screen.bounds.height - 150
                  widthMacOS = heightMacOS / 2
                  windowScene.sizeRestrictions?.minimumSize = CGSize(width: widthMacOS, height: heightMacOS)
                  windowScene.sizeRestrictions?.maximumSize = CGSize(width: widthMacOS, height: heightMacOS)
              }
             
          }
          #endif
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        appSettings.saveUserDefaults()

    }
   
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        appSettings.saveUserDefaults()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        appSettings.saveUserDefaults()
    }
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        appSettings.saveUserDefaults()
    }

}

