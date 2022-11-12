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
    func addPowerBall() {
        removePowerBall()
        let powerNode = SKSpriteNode()
        
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
            powerNode.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.1, size: texture.size())
        } else {
            // This fall back should not happen, but we may use this in the future for iOS' that fail
            powerNode.physicsBody = SKPhysicsBody(circleOfRadius: 27)
        }
        
        powerNode.physicsBody?.categoryBitMask = powerCategory
        powerNode.physicsBody?.contactTestBitMask = paddleCategory + wallCategory
        powerNode.physicsBody?.collisionBitMask = paddleCategory + brickCategory + wallCategory
        
        powerNode.zPosition = 50
        powerNode.physicsBody?.affectedByGravity = false
        powerNode.physicsBody?.isDynamic = true
        powerNode.physicsBody?.allowsRotation = true
        powerNode.physicsBody?.friction = 0
        powerNode.physicsBody?.linearDamping = 0
        powerNode.physicsBody?.angularDamping = 0
        powerNode.physicsBody?.restitution = 1.0
        powerNode.physicsBody?.mass = 1.0
        powerNode.physicsBody?.fieldBitMask = 0
        powerNode.name = "powerball"
        powerNode.position = CGPoint(x: -100,y: -100)
        powerNode.speed = CGFloat(1.0)
        swapper.toggle()
        let negative: CGFloat = swapper ? 1 : 0
        powerNode.addChild(powerTexture)
        //powerNode.physicsBody?.velocity = CGVector(dx: -centerHeight, dy: 2000)
        powerNode.physicsBody?.velocity = CGVector(dx: initialVelocity / CGFloat(2) * negative, dy: initialVelocity)

        anchorNode.addChild(powerNode)
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
        fireBallNode.physicsBody?.collisionBitMask = brickCategory + wallCategory + paddleCategory
        fireBallNode.zPosition = 50
        fireBallNode.physicsBody?.affectedByGravity = false
        fireBallNode.physicsBody?.isDynamic = true
        fireBallNode.physicsBody?.allowsRotation = true
        fireBallNode.physicsBody?.friction = 0
        fireBallNode.physicsBody?.linearDamping = 0.001
        fireBallNode.physicsBody?.angularDamping = 0.001
        fireBallNode.physicsBody?.restitution = 0.5
        fireBallNode.physicsBody?.mass = 0.9
        fireBallNode.physicsBody?.fieldBitMask = 0
        fireBallNode.name = "fireball"
        fireBallNode.addChild(fireBallTexture)
        fireBallNode.position = CGPoint(x: paddleNode.position.x, y: paddleNode.position.y + 50)
        fireBallNode.speed = CGFloat(1.0)
        fireBallNode.alpha = 0.8
        swapper.toggle()
        let negative: CGFloat = swapper ? 1 : -1
        fireBallNode.physicsBody?.velocity = CGVector(dx: initialVelocity / 2 * negative, dy: initialVelocity + CGFloat(settings.level * 2) + 1)

        let copy = fireBallNode.copy() as! SKSpriteNode
        scene?.addChild(copy)
        
        //let remove = SKAction.removeFromParent()
        let wait = SKAction.wait(forDuration: TimeInterval(1 + (settings.level + 1 / 100)))
        let live = SKAction.wait(forDuration: TimeInterval(2 + (settings.level + 1 / 100 * 2)))

        let fade = SKAction.fadeOut(withDuration: 1.0)
        let rmfp = SKAction.removeFromParent()

        let code = SKAction.run {
            self.createFireBall()
        }

        let seq = SKAction.sequence([wait,code,live,fade,rmfp])
        copy.run(seq)
    }
}



