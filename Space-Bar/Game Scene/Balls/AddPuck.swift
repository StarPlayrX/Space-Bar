//
//  AddPuck.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/7/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    //add Puck
    func addPuck(removePreviousPuck: Bool) {
        ballCounter = ballTimeOut
    
        if removePreviousPuck {
            for whatDaPuck in anchorNode.children {
                if let name = whatDaPuck.name, name == "ball" {
                    whatDaPuck.removeFromParent()
                }
            }
        }
    
        ballNode = SKSpriteNode()
        
        let ballEmoji = SKLabelNode(fontNamed:"SpaceBarColors")
        ballEmoji.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        ballEmoji.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        ballEmoji.alpha = 1.0
        ballEmoji.position = CGPoint.zero
        ballEmoji.zPosition = 50
        
        if !removePreviousPuck {
            ballEmoji.text = Global.shared.gameBall[settings.puck + 2 % 8]
        } else {
            ballEmoji.text = Global.shared.gameBall[settings.puck]
        }
        ballEmoji.fontSize = 50 //* 2
        
        let rnd = arc4random_uniform(UInt32(360))
        ballEmoji.zRotation = CGFloat(Int(rnd).degrees)
        
        if let texture = view?.texture(from: ballEmoji) {
            ballNode.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.1, size: texture.size())
        } else {
            ballNode.physicsBody = SKPhysicsBody(circleOfRadius: 27)
        }
        
        ballNode.physicsBody?.categoryBitMask = ballCategory
        ballNode.physicsBody?.contactTestBitMask =
        paddleCategory + wallCategory + goalCategory
        
        ballNode.physicsBody?.collisionBitMask =
        paddleCategory + brickCategory + wallCategory
        
        ballNode.zPosition = 50
        ballNode.physicsBody?.affectedByGravity = true
        ballNode.physicsBody?.isDynamic = true
        ballNode.physicsBody?.allowsRotation = true
        ballNode.physicsBody?.friction = 0
        ballNode.physicsBody?.linearDamping = 0
        ballNode.physicsBody?.angularDamping = 0
        ballNode.physicsBody?.restitution = 1.0
        ballNode.physicsBody?.mass = 1.0
        ballNode.physicsBody?.fieldBitMask = 0
        ballNode.name = "ball"
        ballNode.position = CGPoint(x:0,y:0)
        ballNode.speed = CGFloat(1.0)
        
        swapper.toggle()
        let negative: CGFloat = swapper ? 1 : -1
        ballNode.addChild(ballEmoji)
        ballNode.physicsBody?.velocity = CGVector(dx: initialVelocity / CGFloat(2) + CGFloat(settings.level * 4) * negative, dy: initialVelocity + CGFloat(settings.level * 4))
        
        let copy = ballNode.copy() as! SKSpriteNode
        
        let act = SKAction.run {
            copy.name = "extraball"
            self.anchorNode.addChild(copy)
        }
                
        let wait = SKAction.wait(forDuration: 1.0)
        let seq = SKAction.sequence([wait,act])

        if !removePreviousPuck {
            run(seq)
        } else {
            anchorNode.addChild(copy)
        }
    }
}
