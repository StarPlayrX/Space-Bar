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
    
    func addPuck() {
        
        let ball = "ball"
        
        ballCounter = ballTimeOut
        // Ensures no pucks pre-exist
        for whatDaPuck in anchorNode.children {
            if let name = whatDaPuck.name, name == ball {
                whatDaPuck.removeFromParent()
            }
        }
        
        //ballNode = nil
        ballNode = SKSpriteNode()
        
        let ballEmoji = SKLabelNode(fontNamed:"SpaceBarColors")
        ballEmoji.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        ballEmoji.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        ballEmoji.alpha = 1.0
        ballEmoji.position = CGPoint(x: 0, y: 0)
        ballEmoji.zPosition = 50
        ballEmoji.text = Global.shared.gameBall[settings.puck]
        ballEmoji.fontSize = 50 //* 2
        
        let rnd = arc4random_uniform(UInt32(360))
        ballEmoji.zRotation = CGFloat(Int(rnd).degrees)
        
        if let texture = view?.texture(from: ballEmoji) {
            ballNode.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.1, size: texture.size())
        } else {
            // This fall back should not happen, but we may use this in the future for iOS' that fail
            ballNode.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        }
        
        ballNode.physicsBody?.categoryBitMask = ballCategory
        ballNode.physicsBody?.contactTestBitMask =
        paddleCategory + wallCategory + goalCategory
        
        ballNode.physicsBody?.collisionBitMask =
        paddleCategory + brickCategory + wallCategory
        
        ballNode.zPosition = 50
        ballNode.physicsBody?.affectedByGravity = false
        ballNode.physicsBody?.isDynamic = true
        ballNode.physicsBody?.allowsRotation = true
        ballNode.physicsBody?.friction = 0
        ballNode.physicsBody?.linearDamping = 0
        ballNode.physicsBody?.angularDamping = 0
        ballNode.physicsBody?.restitution = 1.0
        ballNode.physicsBody?.mass = 1.0
        ballNode.physicsBody?.fieldBitMask = 0
        ballNode.name = ball
        extraNode.position = CGPoint(x: 0, y: -100)
        ballNode.speed = CGFloat(1.0)
        ballNode.addChild(ballEmoji)
        ballNode.physicsBody?.velocity = ballSpeed()
        anchorNode.addChild(ballNode)
    }
    
    func ballSpeed() -> CGVector {
        let negative: CGFloat = swapper ? 1 : -1
        swapper.toggle()
        
        return CGVector(dx: (velocity + CGFloat(settings.currentlevel) / 100) / CGFloat(ratio) * negative, dy: velocity + CGFloat(settings.currentlevel) / 50)
    }
    
    func addExtraBall() {
        
        let extraball = "extraball"
        
        // Ensures no pucks pre-exist
//        for whatDaPuck in anchorNode.children {
//            if let name = whatDaPuck.name, name == extraball {
//                whatDaPuck.removeFromParent()
//            }
//        }
        
        //ballNode = nil
        extraNode = SKSpriteNode()
        
        let extraBallEmoji = SKLabelNode(fontNamed:"SpaceBarColors")
        extraBallEmoji.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        extraBallEmoji.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        extraBallEmoji.alpha = 1.0
        extraBallEmoji.position = CGPoint(x: 0, y: 0)
        extraBallEmoji.zPosition = 50
        extraBallEmoji.text = Global.shared.gameBall[settings.puck + 2 % 8]
        extraBallEmoji.fontSize = 50 //* 2
        
        let rnd = arc4random_uniform(UInt32(360))
        extraBallEmoji.zRotation = CGFloat(Int(rnd).degrees)
        
        if let texture = view?.texture(from: extraBallEmoji) {
            extraNode.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.1, size: texture.size())
        } else {
            // This fall back should not happen, but we may use this in the future for iOS' that fail
            extraNode.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        }
        
        extraNode.physicsBody?.categoryBitMask = ballCategory
        extraNode.physicsBody?.contactTestBitMask = paddleCategory + wallCategory + goalCategory
        extraNode.physicsBody?.collisionBitMask = paddleCategory + brickCategory + wallCategory
        extraNode.zPosition = 50
        extraNode.physicsBody?.affectedByGravity = false
        extraNode.physicsBody?.isDynamic = true
        extraNode.physicsBody?.allowsRotation = true
        extraNode.physicsBody?.friction = 0
        extraNode.physicsBody?.linearDamping = 0
        extraNode.physicsBody?.angularDamping = 0
        extraNode.physicsBody?.restitution = 1.0

        extraNode.physicsBody?.mass = 1.0
        extraNode.physicsBody?.fieldBitMask = 0
        extraNode.name = extraball
        extraNode.position = CGPoint(x: 0, y: -100)
        extraNode.speed = CGFloat(1.0)
        extraNode.physicsBody?.velocity = ballSpeed()
        extraNode.addChild(extraBallEmoji)
        anchorNode.addChild(extraNode)
    }
}
