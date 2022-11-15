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
            nodes = [extraNode, ballNode]
        } else if (settings.currentlevel + 1) % 10 == 0 {
            nodes = [ballNode]
        } else if (settings.currentlevel + 1) % 5 == 0 {
            nodes = [tennisNode, ballNode]
        }
        
        for node in nodes {
            guard
                let body = node.physicsBody
            else {
                return
            }
            
            //MARK: Clamp helps prevent up and down ball movement from taking place for less than 5 seconds
            if body.velocity.dy > -99 && body.velocity.dy < 99                                         {
                body.velocity.dy <= zero ? body.applyImpulse(CGVector(dx: 0, dy: -25)) : body.applyImpulse(CGVector(dx: 0, dy: 25))
            }
            
            //MARK: Clamp helps prevent side to side ball movement from taking place for less than 5 seconds
            if body.velocity.dx > -49 && body.velocity.dx < 49                                        {
                body.velocity.dx <= zero ? body.applyImpulse(CGVector(dx: -12.5, dy: 0)) : body.applyImpulse(CGVector(dx: 12.5, dy: 0))
            }
        }
    }
}
