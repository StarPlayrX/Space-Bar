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
        drawParallax()
        gameSceneDelegate = self
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
    }
}
