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

 
    private func addHoverGesture() {
      let hoverGesture
        = UIHoverGestureRecognizer(target: self,
                                   action: #selector(hovering(_:)))
      view.addGestureRecognizer(hoverGesture)
    }

    
    /*
     
     
     @objc func mouseDidMove(with recognizer: UIHoverGestureRecognizer) {

         guard let view = recognizer.view else { return }

         // Calculate the location

         let locationInView = recognizer.location(in: view)

         print(\"Hovering at location \(locationInView)\")

     }

     
     */
    @objc private func hovering(_ recognizer: UIHoverGestureRecognizer) {
      // 1
        
        guard let view = recognizer.view else { return }

        let locationInView = recognizer.location(in: view)

        print("Hovering at location \(locationInView)")

     // guard !isSelected else { return }
      // 2
      switch recognizer.state {
      // 3
      case .began, .changed:
      // 4
          print("began or changed")

      case .ended:
          print("ended")
      default:
        break
      }
    }

    
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
        addHoverGesture()
        
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
