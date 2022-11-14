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

        let nodes = [ballNode, extraNode, tennisNode] //Can be expanded to other balls

        for node in nodes {
            guard
                let x = node.physicsBody?.velocity.dx,
                let y = node.physicsBody?.velocity.dy,
                let body = node.physicsBody,
                let name = node.name,
                name.contains("ball")
            else {
                return
            }

            let absTotal = abs(x) + abs(y)

            if absTotal <= initialVelocity * ratio {
                let maxVelocity = CGFloat(initialVelocity * ratio) + CGFloat(settings.currentlevel)
                booster(body, boost, initialVelocity + CGFloat(settings.currentlevel), maxVelocity)
                
            }
        }
    }

    func booster(_ ballBody: SKPhysicsBody?,_ boost: CGFloat,_ initialVelocity: CGFloat,_ maxVelocity: CGFloat) {
        guard let ballBody = ballBody else { return }
                
        if abs(ballBody.velocity.dx) < abs(initialVelocity) && abs(ballBody.velocity.dx) < maxVelocity / 2 {
            ballBody.velocity.dx <= zero ? (ballBody.velocity.dx -= boost) : (ballBody.velocity.dx += boost)
        }
        
        //MARK: To do switch to a clamp algorithm
        if ballBody.velocity.dx > maxVelocity / 2 {
            ballBody.velocity.dx = maxVelocity / 2
        } else if ballBody.velocity.dx < -maxVelocity / 2 {
            ballBody.velocity.dx = -maxVelocity / 2
        }
        
        if abs(ballBody.velocity.dy) < abs(initialVelocity) && abs(ballBody.velocity.dy) < maxVelocity {
            ballBody.velocity.dy <= zero ? (ballBody.velocity.dy -= boost * ratio) : (ballBody.velocity.dy += boost * ratio)
        }
        
        //To do switch to a clamp algorithm
        if ballBody.velocity.dy > maxVelocity {
            ballBody.velocity.dy = maxVelocity
        } else if ballBody.velocity.dy < -maxVelocity {
            ballBody.velocity.dy = -maxVelocity
        }
    }
}
