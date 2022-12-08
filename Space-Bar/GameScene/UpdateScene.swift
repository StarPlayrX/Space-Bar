//
//  Update.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/7/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    // Called before each frame is rendered (this may be expensive, see if we can just do this on collisions instead)
    override func update(_ currentTime: TimeInterval) {
        var nodes = [ballNode] //Can be expanded to other balls
        
        if (settings.currentlevel + 1) % 20 == 0 {
            nodes = [ballNode, extraNode]
        } else if (settings.currentlevel + 1) % 10 == 0 {
            nodes = [ballNode, gFireBallNode]
        } else if (settings.currentlevel + 1) % 5 == 0 {
            nodes = [ballNode, tennisNode]
        }
        
        for node in nodes {
            guard
                let body = node.physicsBody
            else {
                return
            }
            
            //MARK: If the node is offscreen, nix in 1 second
            if node.name == "ball" {
                if (node.position.x < -node.size.width / 2.0 || node.position.x > self.size.width + node.size.width / 2.0
                    || node.position.y < -node.size.height / 2.0 || node.position.y > self.size.height + node.size.height / 2.0) {
                    ballCounter = 1
                }
            }
        
            #if targetEnvironment(macCatalyst)
                let minSpeed = CGFloat(50)
                let maxSpeed = CGFloat(700)
                let brakesX = 2.5
                let brakesY = 5
            #else
                let minSpeed = CGFloat(100)
                let maxSpeed = CGFloat(800)
                let brakesX = 5
                let brakesY = 10
            #endif
            

            let half  = CGFloat(settings.currentlevel + 1) / 2
            let quart = CGFloat(settings.currentlevel + 1) / 4

            //MARK: Min Speed dy (Thrust)
            if abs(body.velocity.dy) < CGFloat(minSpeed + half) {
                body.velocity.dy <= zero ? body.applyImpulse(CGVector(dx: 0, dy: -brakesY)) : body.applyImpulse(CGVector(dx: 0, dy: brakesY))
            }
            
            //MARK: Min Speed dx (Thrust)
            if abs(body.velocity.dx) < CGFloat(minSpeed + quart) {
                body.velocity.dx <= zero ? body.applyImpulse(CGVector(dx: -brakesX, dy: 0)) : body.applyImpulse(CGVector(dx: brakesX, dy: 0))
            }
    
            //MARK: Max Speed dx (Breaks)
            if abs(body.velocity.dx) > CGFloat(maxSpeed + quart) {
                body.velocity.dx <= zero ? body.applyImpulse(CGVector(dx: brakesX, dy: 0)) : body.applyImpulse(CGVector(dx: -brakesX, dy: 0))
            }
    
            //MARK: Max Speed dy (Breaks)
            if abs(body.velocity.dy) > CGFloat(maxSpeed + half) {
                body.velocity.dy <= zero ? body.applyImpulse(CGVector(dx: 0, dy: brakesY)) : body.applyImpulse(CGVector(dx: 0, dy: -brakesY))
            }
        }
    }
}
