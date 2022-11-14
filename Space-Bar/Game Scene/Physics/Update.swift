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
        
        let nodes = [ballNode,tennisNode,extraNode]
        
        for node in nodes {
            guard
                let x = node.physicsBody?.velocity.dx,
                let y = node.physicsBody?.velocity.dy,
                let body = node.physicsBody
            else {
                return
            }
            
            if node.name != "ball" { return }
            
            let absTotal = abs(x) + abs(y)
            
            if absTotal <= initialVelocity * ratio {
                booster(body, boost, initialVelocity + CGFloat(settings.currentlevel))
            } else if absTotal > initialVelocity + differentiator {
                booster(body, -boost, initialVelocity + differentiator + CGFloat(settings.currentlevel))
            }
        }
    }

    func booster(_ ballBody: SKPhysicsBody?, _ boost: CGFloat, _ initialVelocity: CGFloat ) {
        guard let ballBody = ballBody else { return }
                
        if abs(ballBody.velocity.dx) < abs(initialVelocity) {
            ballBody.velocity.dx <= zero ? (ballBody.velocity.dx -= boost) : (ballBody.velocity.dx += boost)
            
            if ballBody.velocity.dx > 888 {
                ballBody.velocity.dx = 888
            }
        }
        
        if abs(ballBody.velocity.dy) < abs(initialVelocity) {
            ballBody.velocity.dy <= zero ? (ballBody.velocity.dy -= boost * ratio) : (ballBody.velocity.dy += boost * ratio)
            
            if ballBody.velocity.dy > 888 {
                ballBody.velocity.dy = 888
            }
        }
    }
}
