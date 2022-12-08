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

        let MacCatalystVerison = UIDevice.current.systemVersion
        let paddle = SKSpriteNode()
        
        if MacCatalystVerison.starts(with: "10.15") {
            let size = CGSize(width: 130, height: 40)
            paddle.physicsBody = SKPhysicsBody(rectangleOf: size, center: CGPoint.zero)
            paddle.size = size
        } else {
            paddle.physicsBody = SKPhysicsBody(texture: paddleTexture, alphaThreshold: 0.01, size: paddleTexture.size())
            paddle.size = paddleTexture.size()
        }

        paddle.texture = paddleTexture
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
        paddle.name = "paddle"
        paddleNode = paddle
        addChild(paddle)
    }
}
