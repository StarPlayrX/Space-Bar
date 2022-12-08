//
//  GameViewController.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/29/22.
//

import UIKit
import SpriteKit
import AVFoundation
import GameKit
import GameplayKit

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
    
    func authenticateLocalPlayer() {
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = {(viewController, error) -> Void in
            print(localPlayer.displayName)
            
//            let scoreReporter = GKScore(leaderboardIdentifier: "grp.spaceBarHighScores")
//            scoreReporter.value = Int64(102)
//            let scoreArray: [GKScore] = [scoreReporter]
            
//            GKScore.report(scoreArray, withCompletionHandler: {error -> Void in
//                if error != nil {
//                    print("GAMEKIT:", error as Any)
//                }
//
//            })
//
            
            // }
            
            //               if viewController != nil {
            //                    print("HELLO")
            //                   self.present(viewController!, animated: true, completion: nil)
            //               } else {
            //                   print("WORLD")
            //                   print((GKLocalPlayer.local.isAuthenticated))
            //               }
        }
    }
    
    func runGameMenu() {
        if let scene = SKScene(fileNamed: "GameMenu") {
            scene.scaleMode = .aspectFit
            
            // Present the scene
            if let view = self.view as! SKView? {
                view.ignoresSiblingOrder = true
                view.showsFPS = false
                view.showsNodeCount = false
                view.isMultipleTouchEnabled = false
                view.presentScene(scene, transition: SKTransition.fade(withDuration: 2.0))
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateLocalPlayer()
        
        
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
        
        view.backgroundColor = .black
        
        
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
