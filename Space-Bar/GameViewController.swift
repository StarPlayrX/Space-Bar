//
//  GameViewController.swift
//  Space Bar
//
//  Created by Todd Bruss on 10/5/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation


var initialScreenSize = CGSize()

class GameViewController: UIViewController {
   
    
    var g = Global.shared
    let ncDef = NotificationCenter.default


    
    override var prefersHomeIndicatorAutoHidden: Bool {
       return true
    }
   
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return UIRectEdge.bottom
    }
    
    @objc func loadGameView() {
        if let view = view as? SKView,
           let scene = SKScene(fileNamed: "GameMenu") {
            
            initialScreenSize = CGSize(width: view.frame.width, height: view.frame.height)
            scene.scaleMode = .aspectFit
            view.ignoresSiblingOrder = true
            view.showsFields = false
            view.showsPhysics = false
            view.isAsynchronous = true
            view.isMultipleTouchEnabled = false
            view.isOpaque = true
            view.allowsTransparency = false
            view.showsFPS = false
            view.showsNodeCount = false
            view.presentScene(scene, transition: SKTransition.fade(withDuration: 2.0))
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
                
        
        //For some reason the game works better this way, weird stuff (Game over never finishes without this)
        ncDef.addObserver(self,selector: #selector(self.loadGameView), name: NSNotification.Name.init(rawValue: "loadGameView"),object: nil)
        ncDef.post(name: Notification.Name("loadGameView"), object: nil)
        
        #if !targetEnvironment(macCatalyst)
        let audioSession = AVAudioSession.sharedInstance()
        
        if settings.sound {
            try? audioSession.setCategory(.playback, options: [.duckOthers])
        } else {
            try? audioSession.setCategory(.playback, options: [.mixWithOthers])
        }
        
        try? audioSession.setActive(true)
        #endif
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

    override var prefersStatusBarHidden: Bool {
        return true
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

