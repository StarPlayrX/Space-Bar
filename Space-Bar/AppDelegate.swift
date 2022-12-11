//
//  AppDelegate.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/21/22.
//
import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let appSettings = AppSettings()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appSettings.loadUserDefaults()
        appSettings.loadLeaderboard()
        
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
    
    func ditto() {
        appSettings.loadUserDefaults()
        appSettings.loadLeaderboard()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        appSettings.saveUserDefaults()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        ditto()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        setGamerTag()
        ditto()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        appSettings.saveUserDefaults()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        appSettings.saveUserDefaults()
    }
}



//import SpriteKit
//
//var boundsObservation: NSKeyValueObservation?
//
//func beginObservingBounds() {
//    boundsObservation = observe(\.window?.bounds.size) { capturedSelf, _ in
//        // ...
//        print("HELLO")
//    }
//}


/*
 
 func runGameMenu() {
     // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
     // including entities and graphs.
     if let gkScene = GKScene(fileNamed: "GameMenu") {
         
     
         // Get the SKScene from the loaded GKScene
         if let rootNode = gkScene.rootNode as! GameMenu? {
             
             // Copy gameplay related content over to the scene
            // rootNode.entities = gkScene.entities
            // rootNode.graphs = gkScene.graphs
             // Set the scale mode to scale to fit the window
             rootNode.scaleMode = .aspectFit
             
             if let view = self.view as! SKView? {
                 view.ignoresSiblingOrder = true
                 view.showsFPS = false
                 view.showsNodeCount = false
                 view.isMultipleTouchEnabled = false
                 view.presentScene(rootNode, transition: SKTransition.fade(withDuration: 2.0))
             }
         }
     }
 }
 
 
 
 */


//struct Item: Identifiable {
//    let id = UUID()
//    var item: String
//    var description: String = "This is the item description"
//    var quantity: Int = 1
//    var price: Double = 0
//}



// leaderBoard[2] = LeaderBoard(score: 20, playerName: "Player X", start: 1, stop: 100, date: Date())
// leaderBoard[1] = LeaderBoard(score: 20, playerName: "Player X", start: 10, stop: 100, date: Date())
//
//        leaderBoard.sort(by: {($1.score, $1.stop, $0.start) < ($0.score, $0.stop, $1.start)})
//        leaderBoard = Array(leaderBoard[0..<20])

 //if #available(iOS 13.0, *) {
//            struct ContentView: View {
//                var scene: SKScene {
//                    guard let scene = SKScene(fileNamed: "GameMenu") else { return SKScene() }
//                    return scene
//                }
//
//                var body: some View {
//
//                    GeometryReader { (geometry) in
//
//                        //  SpriteView(scene: scene)
//                        List {
//
//                                        Section {
//                                            HStack() {
//
//                                                Text("StarPlayrX")
//                                                    .multilineTextAlignment(.leading)
//                                                    .frame(width: geometry.size.width / 4, alignment: .leading)
//
//
//                                                Text("114")
//                                                    .multilineTextAlignment(.leading)
//                                                    .frame(width: geometry.size.width / 4, alignment: .leading)
//                                                Text("1")
//                                                    .multilineTextAlignment(.leading)
//                                                    .frame(width: geometry.size.width / 4, alignment: .leading)
//                                                Text("2")
//                                                    .multilineTextAlignment(.leading)
//                                                    .frame(width: geometry.size.width / 4, alignment: .leading)
//                                            }
//                                        } header: {
//                                            HStack() {
//                                                Text("Player")
//                                                    .multilineTextAlignment(.leading)
//                                                    .frame(width: geometry.size.width / 4, alignment: .leading)
//                                                Text("Score")
//                                                    .multilineTextAlignment(.leading)
//                                                    .frame(width: geometry.size.width / 4, alignment: .leading)
//                                                Text("Start Level")
//                                                    .multilineTextAlignment(.leading)
//                                                    .frame(width: geometry.size.width / 4, alignment: .leading)
//                                                Text("End Level")
//                                                    .multilineTextAlignment(.leading)
//                                                    .frame(width: geometry.size.width / 4, alignment: .leading)
//                                            }
//                                            .padding(.leading, 55)
//
//                                        }
//
//                                    }
//                        .listStyle(.plain)
//                    }
//
////                    SpriteKitContainer(scene: scene)
////                        .edgesIgnoringSafeArea(.all)
//                }
//            }
     
     
    // let vc = UIHostingController(rootView: ContentView())
   //  window?.rootViewController = vc
//  }
//        } else {
//            // Fallback on earlier versions
//        }

// sendText()
 
 
