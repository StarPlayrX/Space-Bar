//
//  DrawPaddle.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/8/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func drawPaddle() {
        //add our paddle
        let paddleTexture = SKTexture(imageNamed: "paddle")
        let paddlePhysicsBody = SKPhysicsBody(texture: paddleTexture, alphaThreshold: 0.1, size: paddleTexture.size())
        let paddle = SKSpriteNode()
        paddle.texture = paddleTexture
        paddle.physicsBody = paddlePhysicsBody
        paddle.physicsBody?.friction = 0
        paddle.physicsBody?.allowsRotation = false
        paddle.physicsBody?.linearDamping = 0
        paddle.physicsBody?.angularDamping = 0
        paddle.zPosition = 50
        paddle.physicsBody?.isDynamic = false
        paddle.physicsBody?.fieldBitMask = 0
        paddle.physicsBody?.affectedByGravity = false
        paddle.physicsBody?.mass = 2
        paddle.physicsBody?.restitution = 1.0
        paddle.physicsBody?.contactTestBitMask = ballCategory
        paddle.physicsBody?.categoryBitMask = paddleCategory
        paddle.physicsBody?.collisionBitMask = ballCategory
        paddle.position = CGPoint(x:frame.width / 2,y:frame.height / paddleHeight)
        paddle.size = CGSize(width: paddleTexture.size().width, height: paddleTexture.size().height)
        paddle.name = "paddle"
        paddleNode = paddle
        scene?.addChild(paddle)
    }
}
