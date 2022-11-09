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
        
        var ball = (settings.puck + 3) % 8
        
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
        powerNode.physicsBody?.velocity = CGVector(dx: initialVelocity / CGFloat(2) * negative, dy: initialVelocity)
        anchorNode.addChild(powerNode)
    }
}
