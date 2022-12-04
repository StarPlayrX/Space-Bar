//
//  AppDelegate.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/21/22.
//

import UIKit


//
//var boundsObservation: NSKeyValueObservation?
//
//func beginObservingBounds() {
//    boundsObservation = observe(\.window?.bounds.size) { capturedSelf, _ in
//        // ...
//        print("HELLO")
//    }
//}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
  

    
    let appSettings = AppSettings()
    

 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        appSettings.loadUserDefaults()

        #if targetEnvironment(macCatalyst)
        let MacCatalystVerison = UIDevice.current.systemVersion

        UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.forEach { windowScene in
            windowScene.titlebar?.titleVisibility = .hidden
        
            yCoverMacOS = 32

            if let height = settings.height {
                windowHeight = height
                windowWidth = windowHeight / 2
            } else if MacCatalystVerison.starts(with: "10.15") {
                windowHeight = 1300
            } else {
                windowHeight = windowScene.screen.bounds.height - 120
            }
            
            windowWidth = windowHeight / 2
            windowScene.sizeRestrictions?.minimumSize = CGSize(width: windowWidth, height: windowHeight)
            windowScene.sizeRestrictions?.maximumSize = CGSize(width: windowWidth, height: windowHeight)
        }
        #else
        
        windowHeight = 1300
        windowWidth = windowHeight / 2
        
        if #available(iOS 13.0, *) {
            if UIDevice.current.userInterfaceIdiom == .pad {
                if let height = window?.bounds.height {
                    windowHeight = height
                    windowWidth = height / 2
                }
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

