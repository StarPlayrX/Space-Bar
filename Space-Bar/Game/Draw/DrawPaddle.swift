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
        
        
        
        
        let paddle = SKSpriteNode()
        let paddleTexture = SKTexture(imageNamed: "paddle")
        
        let centerRect = SKPhysicsBody(rectangleOf: CGSize(width: 80, height: 40), center: CGPoint.zero)
        paddle.size = CGSize(width: 120, height: 40)
        
        let circleLeft  = SKPhysicsBody(circleOfRadius: 20, center: CGPoint(x: -40, y: 0))
        let circleRight = SKPhysicsBody(circleOfRadius: 20, center: CGPoint(x: 40, y: 0))
    
        //MARK: Paddle ( )===( )
        
        //MARK: Bug or Feature?: Had to use two cloned PhysicsBodies on the Edges to prevent unwanted rotation
        paddle.physicsBody = SKPhysicsBody(bodies: [circleLeft, circleLeft, centerRect, circleRight, circleRight])
        
        
        paddle.texture = paddleTexture
        paddle.physicsBody?.friction = 0.0
        paddle.physicsBody?.allowsRotation = false
        paddle.physicsBody?.linearDamping = 0
        paddle.physicsBody?.angularDamping = 0
        paddle.physicsBody?.isDynamic = false
        paddle.physicsBody?.fieldBitMask = 0
        paddle.physicsBody?.affectedByGravity = false
        paddle.physicsBody?.mass = 2
        paddle.physicsBody?.isResting = true
        paddle.physicsBody?.restitution = 1.0
        paddle.physicsBody?.contactTestBitMask = ballCategory
        paddle.physicsBody?.categoryBitMask = paddleCategory
        paddle.physicsBody?.collisionBitMask = ballCategory + wallCategory
        
        paddle.zPosition = 50
        paddle.position = CGPoint(x:frame.width / 2,y:frame.height / paddleHeight)
        paddle.name = "paddle"
        paddleNode = paddle
        addChild(paddle)
        
       
        
        
        
    }
}
