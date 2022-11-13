//
//  AddPowerBall.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/7/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    //addPower
    func addTennisBall() {
        removePowerBall()
        let tennisBallNode = SKSpriteNode()
        
        let powerTexture = SKLabelNode(fontNamed:"SpaceBarColors")
        powerTexture.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        powerTexture.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        powerTexture.alpha = 1.0
        powerTexture.position = CGPoint(x: 0, y: 0)
        powerTexture.zPosition = 50
        
        var ball = (settings.puck + 6) % 8
        
        if ball > Global.shared.gameBall.count - 1 {
            ball = Global.shared.gameBall.count - 1
        }
        
        powerTexture.text = Global.shared.gameBall[ball]
        powerTexture.fontSize = 50
        
        let rnd = arc4random_uniform(UInt32(360))
        powerTexture.zRotation = CGFloat(Int(rnd).degrees)
        
        if let texture = view?.texture(from: powerTexture) {
            tennisBallNode.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.1, size: texture.size())
        } else {
            // This fall back should not happen, but we may use this in the future for iOS' that fail
            tennisBallNode.physicsBody = SKPhysicsBody(circleOfRadius: 27)
        }
        
        tennisBallNode.physicsBody?.categoryBitMask = powerCategory
        tennisBallNode.physicsBody?.contactTestBitMask = paddleCategory + wallCategory
        tennisBallNode.physicsBody?.collisionBitMask = paddleCategory + brickCategory + wallCategory + goalCategory
        tennisBallNode.zPosition = 50
        tennisBallNode.physicsBody?.affectedByGravity = false
        tennisBallNode.physicsBody?.isDynamic = true
        tennisBallNode.physicsBody?.allowsRotation = true
        tennisBallNode.physicsBody?.friction = 0
        tennisBallNode.physicsBody?.linearDamping = 0
        tennisBallNode.physicsBody?.angularDamping = 0
        tennisBallNode.physicsBody?.restitution = 1.0
        tennisBallNode.physicsBody?.mass = 1.0
        tennisBallNode.physicsBody?.fieldBitMask = 0
        tennisBallNode.name = "fireball"
        tennisBallNode.position = CGPoint(x: -100,y: -100)
        tennisBallNode.speed = CGFloat(1.0)
        tennisBallNode.addChild(powerTexture)

        let negative: CGFloat = CGFloat.random(in: -1...1)
        tennisBallNode.physicsBody?.velocity = ballSpeed(negative)
        
        anchorNode.addChild(tennisBallNode)
    }
    
    
    func createFireBall() {
        let fireBallNode = SKSpriteNode()
        
        let fireBallTexture = SKLabelNode(fontNamed:"SpaceBarColors")
        fireBallTexture.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        fireBallTexture.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        fireBallTexture.alpha = 1.0
        fireBallTexture.position = CGPoint(x: 0, y: 0)
        fireBallTexture.zPosition = 50
        
        var ball = (settings.puck + 3) % 8

        if ball > Global.shared.gameBall.count - 1 {
            ball = Global.shared.gameBall.count - 1
        }
        
        fireBallTexture.text = Global.shared.gameBall[ball]
        fireBallTexture.fontSize = 48
        
        let rnd = arc4random_uniform(UInt32(360))
        fireBallTexture.zRotation = CGFloat(Int(rnd).degrees)
        
        if let texture = view?.texture(from: fireBallTexture) {
            fireBallNode.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.1, size: texture.size())
        } else {
            // This fall back should not happen, but we may use this in the future for iOS' that fail
            fireBallNode.physicsBody = SKPhysicsBody(circleOfRadius: 27)
        }
        
        fireBallNode.physicsBody?.categoryBitMask = fireBallCategory
        fireBallNode.physicsBody?.contactTestBitMask = fireBallCategory + brickCategory
        fireBallNode.physicsBody?.collisionBitMask = brickCategory + wallCategory + paddleCategory + goalCategory   
        fireBallNode.zPosition = 50
        fireBallNode.physicsBody?.affectedByGravity = false
        fireBallNode.physicsBody?.isDynamic = true
        fireBallNode.physicsBody?.allowsRotation = true
        fireBallNode.physicsBody?.friction = 0
        fireBallNode.physicsBody?.linearDamping = 0.001
        fireBallNode.physicsBody?.angularDamping = 0.001
        fireBallNode.physicsBody?.restitution = 1.0
        fireBallNode.physicsBody?.mass = 0.9
        fireBallNode.physicsBody?.fieldBitMask = 0
        fireBallNode.name = "fireball"
        fireBallNode.addChild(fireBallTexture)
        fireBallNode.position = CGPoint(x: paddleNode.position.x, y: paddleNode.position.y + 50)
        fireBallNode.speed = CGFloat(1.0)
        fireBallNode.alpha = 0.85
        fireBallNode.blendMode = .multiply
                
        let negative: CGFloat = CGFloat.random(in: -1...1)
        fireBallNode.physicsBody?.velocity = ballSpeed(negative)
        
        let copy = fireBallNode.copy() as! SKSpriteNode
        scene?.addChild(copy)
        
        //let remove = SKAction.removeFromParent()
        let wait = SKAction.wait(forDuration: TimeInterval(1.0 + Double(settings.level / 100)))
        let live = SKAction.wait(forDuration: TimeInterval(2.0 - Double(settings.level / 100)))

        let fade = SKAction.fadeOut(withDuration: 1.0)
        let rmfp = SKAction.removeFromParent()

        let code = SKAction.run {
            self.createFireBall()
        }

        let seq = SKAction.sequence([wait,code,live,fade,rmfp])
        copy.run(seq)
    }
}



