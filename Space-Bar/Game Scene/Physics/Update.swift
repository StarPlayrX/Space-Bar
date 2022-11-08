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
        guard
            let x = ballNode.physicsBody?.velocity.dx,
            let y = ballNode.physicsBody?.velocity.dy,
            let body = ballNode.physicsBody
        else {
            return
        }
        
        if ballNode.name != "ball" { return }
        
        let absTotal = abs(x) + abs(y)
        
        if absTotal <= initialVelocity * ratio {
            booster(body, boost, initialVelocity)
        } else if absTotal > initialVelocity + differentiator {
            booster(body, -boost, initialVelocity + differentiator)
        }
    }

    func booster(_ ballBody: SKPhysicsBody?, _ boost: CGFloat, _ initialVelocity: CGFloat ) {
        guard let ballBody = ballBody else { return }
        
        let ratio = 1.5
        
        if abs(ballBody.velocity.dx) < abs(initialVelocity) {
            ballBody.velocity.dx <= zero ? (ballBody.velocity.dx -= boost) : (ballBody.velocity.dx += boost)
        }
        
        if abs(ballBody.velocity.dy) < abs(initialVelocity) {
            ballBody.velocity.dy <= zero ? (ballBody.velocity.dy -= boost * ratio) : (ballBody.velocity.dy += boost * ratio)
        }
    }
}
