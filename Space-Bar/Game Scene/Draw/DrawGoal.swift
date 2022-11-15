//
//  DrawGoal.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/8/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func drawGoal() {
        let goalWallRightNode = SKSpriteNode()
        let goalWallRightNodeSize = CGSize(width: 4, height: 66)
        let goalWallRightPhysicsBody = SKPhysicsBody(rectangleOf: goalWallRightNodeSize)
        goalWallRightNode.color = .systemRed
        goalWallRightNode.physicsBody = goalWallRightPhysicsBody
        goalWallRightNode.physicsBody?.affectedByGravity = false
        goalWallRightNode.physicsBody?.friction = 0
        goalWallRightNode.physicsBody?.fieldBitMask = 0
        goalWallRightNode.physicsBody?.allowsRotation = false
        goalWallRightNode.physicsBody?.linearDamping = 0
        goalWallRightNode.physicsBody?.angularDamping = 0
        goalWallRightNode.zPosition = 0
        goalWallRightNode.physicsBody?.isDynamic = false
        goalWallRightNode.physicsBody?.mass = 1.0
        goalWallRightNode.physicsBody?.contactTestBitMask = ballCategory
        goalWallRightNode.physicsBody?.categoryBitMask = wallCategory
        goalWallRightNode.physicsBody?.collisionBitMask = wallCategory + ballCategory
        goalWallRightNode.position = CGPoint(x: centerWidth / 3 + 3, y: -centerHeight + 32)
        goalWallRightNode.size = goalWallRightNodeSize
        goalWallRightNode.physicsBody?.restitution = 0.125
        goalWallRightNode.name = "wall"
        goalWallRightNode.alpha = 0.667 
        anchorNode.addChild(goalWallRightNode)
        
        let goalWallLeftNode = SKSpriteNode()
        let goalWallLeftNodeSize = CGSize(width: 4, height: 66)
        let goalWallLeftPhysicsBody = SKPhysicsBody(rectangleOf: goalWallLeftNodeSize)
        goalWallLeftNode.color = .systemRed
        goalWallLeftNode.physicsBody = goalWallLeftPhysicsBody
        goalWallLeftNode.physicsBody?.affectedByGravity = false
        goalWallLeftNode.physicsBody?.friction = 0
        goalWallLeftNode.physicsBody?.fieldBitMask = 0
        goalWallLeftNode.physicsBody?.allowsRotation = false
        goalWallLeftNode.physicsBody?.linearDamping = 0
        goalWallLeftNode.physicsBody?.angularDamping = 0
        goalWallLeftNode.zPosition = 0
        goalWallLeftNode.physicsBody?.isDynamic = false
        goalWallLeftNode.physicsBody?.mass = 1.0
        goalWallLeftNode.physicsBody?.contactTestBitMask = ballCategory
        goalWallLeftNode.physicsBody?.categoryBitMask = wallCategory
        goalWallLeftNode.physicsBody?.collisionBitMask = wallCategory + ballCategory
        goalWallLeftNode.position = CGPoint(x: (centerWidth / -3) - 2, y: -centerHeight + 32)
        goalWallLeftNode.size = goalWallLeftNodeSize
        goalWallLeftNode.physicsBody?.restitution = 0.125
        goalWallLeftNode.name = "wall"
        goalWallLeftNode.alpha = 0.667
        anchorNode.addChild(goalWallLeftNode)
        
        let goalNode = SKSpriteNode()
        let goalNodeSize = CGSize(width: width / 3, height: 4)
        let goalPhysicsBody = SKPhysicsBody(rectangleOf: goalNodeSize)
        goalNode.color = .systemRed
        goalNode.physicsBody = goalPhysicsBody
        goalNode.physicsBody?.affectedByGravity = false
        goalNode.physicsBody?.friction = 0
        goalNode.physicsBody?.allowsRotation = false
        goalNode.physicsBody?.linearDamping = 0
        goalNode.physicsBody?.angularDamping = 0
        goalNode.zPosition = 50
        goalNode.physicsBody?.isDynamic = false
        goalNode.physicsBody?.mass = 1.0
        goalNode.physicsBody?.contactTestBitMask = ballCategory
        goalNode.physicsBody?.categoryBitMask = goalCategory
        goalNode.position = CGPoint(x:0,y:-centerHeight + 2)
        goalNode.size = goalNodeSize
        goalNode.physicsBody?.restitution = 1.0
        goalNode.name = "goal"
        goalNode.alpha = 0.667
        anchorNode.addChild(goalNode)
    }
}
