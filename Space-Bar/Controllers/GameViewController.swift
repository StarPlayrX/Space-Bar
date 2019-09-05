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
var settings : appsettings = (level: 1, highlevel: 2, emoji: 1, score: 0, highscore: 0, lives: 3, music: true, sound: true, stick: true, mode: 0)

var deviceType = UIDevice().type


let view = SKView()
var forever = SKAction()

class GameViewController: UIViewController {
    
    /*
     No longer in use
    func getDeviceSize() {
        // iPhone detection
        let screenWidth = Int(UIScreen.main.bounds.size.width)
        let screenHeight = Int(UIScreen.main.bounds.size.height)
        let screenMax = Int(max(screenWidth,screenHeight))
        let iPhone = (screenMax == 568 || screenMax == 667 || screenMax == 736)
        let iPhoneX = screenMax == 812
        
        settings.mode = 1 // iPad
        
        if iPhone {
            //Previous iPhones
            settings.mode = 2
        } else if iPhoneX {
            //iPhone Ten
            settings.mode = 4
        }
    }
    */
    
    func setSceneSizeForGame(scene:SKScene ) -> Void {
            
        //Put this in a common area
        if ( deviceType == .iPhone) {
            // iPhone
            scene.size = CGSize(width: 687, height: 1222)
            
        } else if (deviceType == .iPhoneX ) {
            // iPhone X
            scene.size = CGSize(width: 687, height: 1488)
    
        } else {
            //iPad
            scene.size = CGSize(width: 900, height: 1200)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getDeviceSize()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameMenu") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                
                //set the scene size
                setSceneSizeForGame(scene: scene)

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
