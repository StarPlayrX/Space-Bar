//
//  SceneDidLoad.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/25/22.
//

import Foundation
import SpriteKit

extension GameScene: SKPhysicsContactDelegate {
    override func sceneDidLoad() {
        speed = 1
        
        #if targetEnvironment(macCatalyst)
        gameSceneDelegate = self
        #endif
        
        physicsWorld.gravity.dx = 0
        physicsWorld.gravity.dy = 0
        physicsWorld.contactDelegate = self
    }
}
