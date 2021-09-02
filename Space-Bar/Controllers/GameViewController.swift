//
//  GameViewController.swift
//  Space Bar
//
//  Created by Todd Bruss on 2/5/18.
//  Copyright © 2018 Todd Bruss. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {
    
    let ncDef = NotificationCenter.default

    @objc func loadGameMenu() {

        if let view = self.view as? SKView,
           let scene = SKScene(fileNamed: "GameMenu") {
            
            settings.initialScreenSize = CGSize(width: view.frame.width, height: view.frame.height)
            scene.scaleMode = .aspectFit
            view.ignoresSiblingOrder = true
            view.showsFields = false
            view.showsPhysics = false
            view.isAsynchronous = true
            view.isOpaque = true
            view.allowsTransparency = false
            view.showsFPS = false
            view.showsNodeCount = false
            view.presentScene(scene, transition: SKTransition.fade(withDuration: 2))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ncDef.addObserver(self,selector: #selector(self.loadGameMenu), name: NSNotification.Name.init(rawValue: "loadGameMenu"),object: nil)
        ncDef.post(name: Notification.Name("loadGameMenu"), object: nil)
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
