//
//  GameViewController.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/21/22.
//

//import UIKit
//import SpriteKit
//import GameplayKit
//
//var initialScreenSize = CGSize()
//
//class GameViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        if let view = self.view as! SKView? {
//            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "GameMenu") {
//                // Present the scene
//                scene.scaleMode = .aspectFit
//                view.ignoresSiblingOrder = true
//                view.showsFields = false
//                view.showsPhysics = false
//                view.isAsynchronous = true
//                view.isMultipleTouchEnabled = false
//                view.isOpaque = true
//                view.allowsTransparency = false
//                view.showsFPS = false
//
//                view.showsNodeCount = false
//                //view.preferredFramesPerSecond = 30
//
//                view.presentScene(scene, transition: SKTransition.fade(withDuration: 2.0))
//            }
//
////            view.ignoresSiblingOrder = true
////
////            view.showsFPS = true
////            view.showsNodeCount = true
//        }
//    }
//
////    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
////        if UIDevice.current.userInterfaceIdiom == .phone {
////            return [.portrait, .allButUpsideDown]
////        } else if UIDevice.current.userInterfaceIdiom == .pad {
////            return [.portrait, .allButUpsideDown]
////        }
////
////        return [.portrait]
////
////    }
//
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
//}




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
            //view.preferredFramesPerSecond = 30

            view.presentScene(scene, transition: SKTransition.fade(withDuration: 2.0))
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        ncDef.addObserver(self,selector: #selector(self.loadGameView), name: NSNotification.Name.init(rawValue: "loadGameView"),object: nil)
        ncDef.post(name: Notification.Name("loadGameView"), object: nil)
        
        let audioSession = AVAudioSession.sharedInstance()
        
        if settings.sound {
            try? audioSession.setCategory(.playback, options: [.duckOthers])
        } else {
            try? audioSession.setCategory(.playback, options: [.mixWithOthers])
        }
        
        try? audioSession.setActive(true)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
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
}
