//
//  DrawMiddies.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/8/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func drawMidCorners() {
        //left mid corner piece, removed physicsBody, using corner edges instead, this is for looks only
        let leftMidNode = SKSpriteNode()
        let leftMidTexture = SKTexture(imageNamed: "leftmid")
        leftMidNode.texture = leftMidTexture
        leftMidNode.size = CGSize(width: 36, height: 64)
        leftMidNode.position = CGPoint(x: -centerWidth + (corneredge / 2), y: 0)
        leftMidNode.alpha = 1.0
        anchorNode.addChild(leftMidNode)
        
        //right mid corner piece, removed physicsBody, using corner edges instead, this is for looks only
        let rightMidNode = SKSpriteNode()
        let rightMidTexture = SKTexture(imageNamed: "rightmid")
        rightMidNode.texture = rightMidTexture
        rightMidNode.size = CGSize(width: 36, height: 64)
        rightMidNode.position = CGPoint(x: centerWidth - (corneredge / 2) - 2, y: 0)
        rightMidNode.alpha = 1.0
        anchorNode.addChild(rightMidNode)
    }
    
    //This is a fix for Mac Catalyst 10.15.7, but we worked it out so the same code applies to all versions of MC
    func drawMidEdges() {
        let size = CGSize(width: 64, height: 64)
        //left mid corner piece
        let leftMidNode = SKSpriteNode()
        let leftMidBody = SKPhysicsBody(rectangleOf: size)

        leftMidNode.zRotation = .pi / 4
        leftMidNode.physicsBody = leftMidBody
        leftMidNode.physicsBody?.friction = 0
        leftMidNode.physicsBody?.fieldBitMask = 0
        leftMidNode.physicsBody?.contactTestBitMask = ballCategory
        leftMidNode.physicsBody?.categoryBitMask = wallCategory
        leftMidNode.physicsBody?.collisionBitMask = wallCategory + ballCategory
        leftMidNode.physicsBody?.restitution = 1.0
        leftMidNode.name = "resetcounter"
        leftMidNode.physicsBody?.mass = 1
        leftMidNode.physicsBody?.isDynamic = false
        leftMidNode.physicsBody?.affectedByGravity = false
        leftMidNode.size = size
        leftMidNode.position = CGPoint(x: -centerWidth + (corneredge / -2) + 4, y: 0)
        anchorNode.addChild(leftMidNode)
        
        //right mid corner piece
        let rightMidNode = SKSpriteNode()
        let rightMidBody = SKPhysicsBody(rectangleOf: size)

        rightMidNode.zRotation = .pi / 4
        rightMidNode.physicsBody = rightMidBody
        rightMidNode.physicsBody?.friction = 0
        rightMidNode.physicsBody?.fieldBitMask = 0
        rightMidNode.physicsBody?.contactTestBitMask = ballCategory
        rightMidNode.physicsBody?.categoryBitMask = wallCategory
        rightMidNode.physicsBody?.collisionBitMask = wallCategory + ballCategory
        rightMidNode.physicsBody?.restitution = 1.0
        rightMidNode.name = "resetcounter"
        rightMidNode.physicsBody?.mass = 1
        rightMidNode.physicsBody?.isDynamic = false
        rightMidNode.physicsBody?.affectedByGravity = false
        rightMidNode.size = size
        rightMidNode.position = CGPoint(x: centerWidth - (corneredge / -2) - 4, y: 0)
        anchorNode.addChild(rightMidNode)
    }
}
