//
//  GameViewController.swift
//  Space Bar
//
//  Created by Todd Bruss on 2/5/18.
//  Copyright © 2018 Todd Bruss. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

typealias appsettings =  (level: Int, highlevel: Int, emoji: Int, score: Int, highscore: Int, lives: Int, music: Bool, sound: Bool, stick: Bool, mode: Int)
var settings : appsettings = (level: 15, highlevel: 2, emoji: 1, score: 0, highscore: 0, lives: 9, music: true, sound: true, stick: true, mode: 0)

let view = SKView()
var forever = SKAction()
var initialScreenSize = CGSize()

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            initialScreenSize = CGSize(width: view.frame.width, height: view.frame.height)
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameMenu") {

                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit

                // Present the scene
                view.ignoresSiblingOrder = true
                view.showsFields = false
                view.showsPhysics = false
                view.isAsynchronous = true
                view.preferredFramesPerSecond = 60
                view.isOpaque = true
                view.allowsTransparency = false
                view.showsFPS = true
                view.showsNodeCount = false
                view.presentScene(scene)
            }
        }
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
