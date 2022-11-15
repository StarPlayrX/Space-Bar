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
            nodes = [ballNode]
        } else if (settings.currentlevel + 1) % 5 == 0 {
            nodes = [ballNode, tennisNode]
        }
        
        for node in nodes {
            guard
                let body = node.physicsBody
            else {
                return
            }
            
            let level = CGFloat(settings.currentlevel + 1)
            let half  = CGFloat(settings.currentlevel + 1) / 2
            let quart = CGFloat(settings.currentlevel + 1) / 4

            //MARK: Min Speed dy (Thrust)
            if abs(body.velocity.dy) < CGFloat(99 + half) {
                body.velocity.dy <= zero ? body.applyImpulse(CGVector(dx: 0, dy: -25)) : body.applyImpulse(CGVector(dx: 0, dy: 25))
            }
            
            //MARK: Min Speed dx (Thrust)
            if abs(body.velocity.dx) < CGFloat(99 + quart) {
                body.velocity.dx <= zero ? body.applyImpulse(CGVector(dx: -12.5, dy: 0)) : body.applyImpulse(CGVector(dx: 12.5, dy: 0))
            }
            
            //MARK: Max Speed dy (Breaks)
            if abs(body.velocity.dy) > CGFloat(1199 + level) {
                body.velocity.dy <= zero ? body.applyImpulse(CGVector(dx: 0, dy: 12.5)) : body.applyImpulse(CGVector(dx: 0, dy: -12.5))
            }
            
            //MARK: Max Speed dx (Breaks)
            if abs(body.velocity.dx) > CGFloat(1199 + half) {
                body.velocity.dx <= zero ? body.applyImpulse(CGVector(dx: 25, dy: 0)) : body.applyImpulse(CGVector(dx: -25, dy: 0))
            }
        }
    }
}
