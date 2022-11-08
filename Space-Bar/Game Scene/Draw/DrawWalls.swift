//
//  DrawWalls.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/8/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func drawWalls() {
        let topWall = SKSpriteNode()
        let topWallSize = CGSize(width: width + 2, height: 4)
        topWall.physicsBody = SKPhysicsBody(rectangleOf: topWallSize)
        topWall.color = .systemBlue
        topWall.physicsBody?.affectedByGravity = false
        topWall.physicsBody?.friction = 0
        topWall.physicsBody?.allowsRotation = false
        topWall.physicsBody?.linearDamping = 0
        topWall.physicsBody?.angularDamping = 0
        topWall.zPosition = 50
        topWall.physicsBody?.isDynamic = false
        topWall.physicsBody?.mass = 1.0
        topWall.physicsBody?.contactTestBitMask = ballCategory
        topWall.physicsBody?.categoryBitMask = wallCategory
        topWall.physicsBody?.collisionBitMask = wallCategory + ballCategory
        topWall.position = CGPoint(x: 0, y: height / 2 - 60)
        topWall.size = topWallSize
        topWall.physicsBody?.restitution = 0.5
        topWall.name = "wall"
        topWall.alpha = 0.667
        anchorNode.addChild(topWall)
        
        let upperLeftWall = SKSpriteNode()
        let upperLeftWallSize = CGSize(width: 4, height: centerHeight - 90)
        upperLeftWall.physicsBody = SKPhysicsBody(rectangleOf: upperLeftWallSize)
        upperLeftWall.color = .systemBlue
        upperLeftWall.physicsBody?.affectedByGravity = false
        upperLeftWall.physicsBody?.friction = 0
        upperLeftWall.physicsBody?.allowsRotation = false
        upperLeftWall.physicsBody?.linearDamping = 0
        upperLeftWall.physicsBody?.angularDamping = 0
        upperLeftWall.zPosition = 50
        upperLeftWall.physicsBody?.isDynamic = false
        upperLeftWall.physicsBody?.mass = 1.0
        upperLeftWall.physicsBody?.contactTestBitMask = ballCategory
        upperLeftWall.physicsBody?.categoryBitMask = wallCategory
        upperLeftWall.physicsBody?.collisionBitMask = wallCategory + ballCategory
        upperLeftWall.position = CGPoint(x: -centerWidth + 2, y: centerHeight / 2 - 16)
        upperLeftWall.size = upperLeftWallSize
        upperLeftWall.physicsBody?.restitution = 0.5
        upperLeftWall.name = "wall"
        upperLeftWall.alpha = 0.667
        anchorNode.addChild(upperLeftWall)
        
        let upperRightWall = SKSpriteNode()
        let upperRightWallSize = CGSize(width: 4, height: centerHeight - 90)
        upperRightWall.physicsBody = SKPhysicsBody(rectangleOf: upperRightWallSize)
        upperRightWall.color = .systemBlue
        upperRightWall.physicsBody?.affectedByGravity = false
        upperRightWall.physicsBody?.friction = 0
        upperRightWall.physicsBody?.allowsRotation = false
        upperRightWall.physicsBody?.linearDamping = 0
        upperRightWall.physicsBody?.angularDamping = 0
        upperRightWall.zPosition = 50
        upperRightWall.physicsBody?.isDynamic = false
        upperRightWall.physicsBody?.mass = 1.0
        upperRightWall.physicsBody?.contactTestBitMask = ballCategory
        upperRightWall.physicsBody?.categoryBitMask = wallCategory
        upperRightWall.physicsBody?.collisionBitMask = wallCategory + ballCategory
        upperRightWall.position = CGPoint(x: centerWidth - 2, y: centerHeight / 2 - 16)
        upperRightWall.size = upperRightWallSize
        upperRightWall.physicsBody?.restitution = 0.5
        upperRightWall.name = "wall"
        upperRightWall.alpha = 0.667
        anchorNode.addChild(upperRightWall)
        
        let lowerLeftWall = SKSpriteNode()
        let lowerLeftWallSize = CGSize(width: 4, height: centerHeight - 92)
        lowerLeftWall.physicsBody = SKPhysicsBody(rectangleOf: lowerLeftWallSize)
        lowerLeftWall.color = .systemBlue
        lowerLeftWall.physicsBody?.affectedByGravity = false
        lowerLeftWall.physicsBody?.friction = 0
        lowerLeftWall.physicsBody?.allowsRotation = false
        lowerLeftWall.physicsBody?.linearDamping = 0
        lowerLeftWall.physicsBody?.angularDamping = 0
        lowerLeftWall.zPosition = 50
        lowerLeftWall.physicsBody?.isDynamic = false
        lowerLeftWall.physicsBody?.mass = 1.0
        lowerLeftWall.physicsBody?.contactTestBitMask = ballCategory
        lowerLeftWall.physicsBody?.categoryBitMask = wallCategory
        lowerLeftWall.physicsBody?.collisionBitMask = wallCategory + ballCategory
        lowerLeftWall.position = CGPoint(x: -centerWidth + 2, y: -centerHeight / 2 + 18)
        lowerLeftWall.size = lowerLeftWallSize
        lowerLeftWall.physicsBody?.restitution = 0.5
        lowerLeftWall.name = "wall"
        lowerLeftWall.alpha = 0.667
        anchorNode.addChild(lowerLeftWall)
        
        let lowerRightWall = SKSpriteNode()
        let lowerRightWallSize = CGSize(width: 4, height: centerHeight - 92)
        lowerRightWall.physicsBody = SKPhysicsBody(rectangleOf: lowerRightWallSize)
        lowerRightWall.color = .systemBlue
        lowerRightWall.physicsBody?.affectedByGravity = false
        lowerRightWall.physicsBody?.friction = 0
        lowerRightWall.physicsBody?.allowsRotation = false
        lowerRightWall.physicsBody?.linearDamping = 0
        lowerRightWall.physicsBody?.angularDamping = 0
        lowerRightWall.zPosition = 50
        lowerRightWall.physicsBody?.isDynamic = false
        lowerRightWall.physicsBody?.mass = 1.0
        lowerRightWall.physicsBody?.contactTestBitMask = ballCategory
        lowerRightWall.physicsBody?.categoryBitMask = wallCategory
        lowerRightWall.physicsBody?.collisionBitMask = wallCategory + ballCategory
        lowerRightWall.position = CGPoint(x: centerWidth - 2, y: -centerHeight / 2 + 18)
        lowerRightWall.size = lowerRightWallSize
        lowerRightWall.physicsBody?.restitution = 0.5
        lowerRightWall.name = "wall"
        lowerRightWall.alpha = 0.667
        anchorNode.addChild(lowerRightWall)
        
        let recessWallNodeR = SKSpriteNode()
        recessWallNodeR.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width / 3, height: 4))
        recessWallNodeR.color = .systemBlue
        recessWallNodeR.physicsBody?.affectedByGravity = false
        recessWallNodeR.physicsBody?.friction = 0
        recessWallNodeR.physicsBody?.allowsRotation = false
        recessWallNodeR.physicsBody?.linearDamping = 0
        recessWallNodeR.physicsBody?.angularDamping = 0
        recessWallNodeR.zPosition = 50
        recessWallNodeR.physicsBody?.isDynamic = false
        recessWallNodeR.physicsBody?.mass = 1.0
        recessWallNodeR.physicsBody?.contactTestBitMask = ballCategory
        recessWallNodeR.physicsBody?.categoryBitMask = wallCategory
        recessWallNodeR.physicsBody?.collisionBitMask = wallCategory + ballCategory
        recessWallNodeR.position = CGPoint(x: (width + 2) / -3, y: -centerHeight + 64)
        recessWallNodeR.size = CGSize(width: (width + 2) / 3, height: 4)
        recessWallNodeR.physicsBody?.restitution = 0.5
        recessWallNodeR.name = "wall"
        recessWallNodeR.alpha = 0.667
        anchorNode.addChild(recessWallNodeR)
        
        let recessWallNodeL = SKSpriteNode()
        recessWallNodeL.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width / 3, height: 4))
        recessWallNodeL.color = .systemBlue
        recessWallNodeL.physicsBody?.affectedByGravity = false
        recessWallNodeL.physicsBody?.friction = 0
        recessWallNodeL.physicsBody?.allowsRotation = false
        recessWallNodeL.physicsBody?.linearDamping = 0
        recessWallNodeL.physicsBody?.angularDamping = 0
        recessWallNodeL.zPosition = 50
        recessWallNodeL.physicsBody?.isDynamic = false
        recessWallNodeL.physicsBody?.mass = 1.0
        recessWallNodeL.physicsBody?.contactTestBitMask = ballCategory
        recessWallNodeL.physicsBody?.categoryBitMask = wallCategory
        recessWallNodeL.physicsBody?.collisionBitMask = wallCategory + ballCategory
        recessWallNodeL.position = CGPoint(x: (width + 2) / 3, y: -centerHeight + 64)
        recessWallNodeL.size = CGSize(width: (width + 2) / 3, height: 4)
        recessWallNodeL.physicsBody?.restitution = 0.5
        recessWallNodeL.name = "wall"
        recessWallNodeL.alpha = 0.667
        anchorNode.addChild(recessWallNodeL)
    }
}
