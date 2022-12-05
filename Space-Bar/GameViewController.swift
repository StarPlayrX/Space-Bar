//
//  GameViewController.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/29/22.
//

import UIKit
import SpriteKit
//import GameplayKit
import AVFoundation



class GameViewController: UIViewController {
    
   
    
   
    
    
    func runAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        
        if settings.sound {
            try? audioSession.setCategory(.playback, options: [.duckOthers])
        } else {
            try? audioSession.setCategory(.playback, options: [.mixWithOthers])
        }
        
        try? audioSession.setActive(true)
    }
    
    func runGameMenu() {
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = SKScene(fileNamed: "GameMenu") {
            // Get the SKScene from the loaded GKScene
            //if let rootNode = gkScene.rootNode as! GameMenu? {
                
                // Copy gameplay related content over to the scene
                //sceneNode.entities = scene.entities
                //sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.ignoresSiblingOrder = true
                    view.showsFPS = false
                    view.showsNodeCount = false
                    view.isMultipleTouchEnabled = false
                    view.presentScene(scene, transition: SKTransition.fade(withDuration: 2.0))
                }
            //}
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if targetEnvironment(macCatalyst)
        runAudioSession()
        #endif
        
        self.runGameMenu()
    }

    override var prefersHomeIndicatorAutoHidden: Bool {
       return true
   }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone || UIDevice.current.userInterfaceIdiom == .pad {
            return [.portrait, .portraitUpsideDown]
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        func bitSet(_ bits: [Int]) -> UInt {
            return bits.reduce(0) { $0 | (1 << $1) }
        }

        func property(_ property: String, object: NSObject, set: [Int], clear: [Int]) {
            if let value = object.value(forKey: property) as? UInt {
                object.setValue((value & ~bitSet(clear)) | bitSet(set), forKey: property)
            }
        }

        // disable full-screen button
        if  let NSApplication = NSClassFromString("NSApplication") as? NSObject.Type,
            let sharedApplication = NSApplication.value(forKeyPath: "sharedApplication") as? NSObject,
            let windows = sharedApplication.value(forKeyPath: "windows") as? [NSObject]
        {
            for window in windows {
                let floating = 1

                let resizable = 3
                let fullScreenPrimary = 7
                let fullScreenAuxiliary = 8
                let fullScreenNone = 9
                
                property("level", object: window, set: [floating], clear: [])

                property("styleMask", object: window, set: [resizable], clear: [])
                property("collectionBehavior", object: window, set: [fullScreenNone], clear: [fullScreenPrimary, fullScreenAuxiliary])
            }
        }
        
    }
}

//func isFullScreen() -> Bool
//{
//    guard let windows = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID) else {
//        return false
//    }
//
//    for window in windows as NSArray
//    {
//        guard let winInfo = window as? NSDictionary else { continue }
//        
//        if winInfo["kCGWindowOwnerName"] as? String == "Dock",
//           winInfo["kCGWindowName"] as? String == "Fullscreen Backdrop"
//        {
//            return true
//        }
//    }
//    
//    return false
//}
//
//var item = isFullScreen() {
//    didSet { //called when item changes
//        print("isFullScreen", item)
//    }
//    willSet {
//        print("isFullScreen", item)
//    }
//}
