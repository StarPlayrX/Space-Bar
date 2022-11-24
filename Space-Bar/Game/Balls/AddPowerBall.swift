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
            tennisNode.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.1, size: texture.size())
        } else {
            // This fall back should not happen, but we may use this in the future for iOS' that fail
            tennisNode.physicsBody = SKPhysicsBody(circleOfRadius: 27)
        }
        
        tennisNode.physicsBody?.categoryBitMask = powerCategory
        tennisNode.physicsBody?.contactTestBitMask = paddleCategory + wallCategory
        tennisNode.physicsBody?.collisionBitMask = paddleCategory + brickCategory + wallCategory + goalCategory
        tennisNode.zPosition = 50
        tennisNode.physicsBody?.affectedByGravity = false
        tennisNode.physicsBody?.isDynamic = true
        tennisNode.physicsBody?.allowsRotation = true
        tennisNode.physicsBody?.friction = 0
        tennisNode.physicsBody?.linearDamping = 0
        tennisNode.physicsBody?.angularDamping = 0
        tennisNode.physicsBody?.restitution = 1.0
        tennisNode.physicsBody?.mass = 1.0
        tennisNode.physicsBody?.fieldBitMask = 0
        tennisNode.name = "fireball"
        tennisNode.position = CGPoint.zero
        tennisNode.speed = CGFloat(1.0)
        tennisNode.physicsBody?.velocity = ballSpeed()
        tennisNode.addChild(powerTexture)
        anchorNode.addChild(tennisNode)
    }
    
    
    func shootFireBalls() {
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
        fireBallNode.physicsBody?.linearDamping = 0
        fireBallNode.physicsBody?.angularDamping = 0
        fireBallNode.physicsBody?.restitution = 1.0
        fireBallNode.physicsBody?.mass = 0.9
        fireBallNode.physicsBody?.fieldBitMask = 0
        fireBallNode.name = "fireball"
        fireBallNode.addChild(fireBallTexture)
        fireBallNode.position = CGPoint(x: paddleNode.position.x, y: paddleNode.position.y + 50)
        fireBallNode.speed = CGFloat(1.0)
        fireBallNode.alpha = 0.85
        fireBallNode.blendMode = .multiply
        
        let fireRnd = Int.random(in: -1...1)
        fireBallNode.physicsBody?.velocity = CGVector(dx: 50 * CGFloat(fireRnd), dy: (velocity + CGFloat(settings.level)) + (50 * 7))
        
        let copy = fireBallNode.copy() as! SKSpriteNode
        scene?.addChild(copy)
        
        //let remove = SKAction.removeFromParent()
        let half = SKAction.wait(forDuration: TimeInterval(1.5 / 2 - Double(settings.level / 200)))
        let life = SKAction.wait(forDuration: TimeInterval(1.5 - Double(settings.level / 200)))

        let fade = SKAction.fadeOut(withDuration: 1.0)
        let rmfp = SKAction.removeFromParent()

        let code = SKAction.run {
            self.shootFireBalls()
        }

        let seq = SKAction.sequence([half,code,life,fade,rmfp])
        copy.run(seq)
    }
    
    func scaleNode() {
       
    }
}



