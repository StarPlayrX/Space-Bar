//
//  DrawCenterCourt.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/8/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func drawCenterCourt() {
        //MARK: centercourt circle
        let centerCourtNode = SKShapeNode(circleOfRadius: centerWidth / 3 + 4)
        centerCourtNode.strokeColor = .systemRed
        centerCourtNode.lineWidth = 3.0
        centerCourtNode.glowWidth = 1.0
        centerCourtNode.alpha = 0.5
        centerCourtNode.name = "centercircle"

        centerCourtNode.fillColor = SKColor.clear
        centerCourtNode.position = CGPoint.zero
        anchorNode.addChild(centerCourtNode)
        
        //MARK: centercourt line
        let centerCourtLineNode = SKSpriteNode()
        let centerCourtLineSize = CGSize(width:centerWidth * 2 - 64, height: 4)
        let centerLineBody = SKPhysicsBody(rectangleOf: centerCourtLineSize)
        centerCourtLineNode.color = .systemRed
        centerCourtLineNode.alpha = 0.5
        centerCourtLineNode.name = "CenterLine"
        centerCourtLineNode.physicsBody = centerLineBody
        centerCourtLineNode.physicsBody?.contactTestBitMask = ballCategory
        centerCourtLineNode.physicsBody?.categoryBitMask = midFieldCategory
        centerCourtLineNode.physicsBody?.collisionBitMask = midFieldCategory + ballCategory
        centerCourtLineNode.physicsBody?.isDynamic = false
        centerCourtLineNode.physicsBody?.affectedByGravity = false
        centerCourtLineNode.size = centerCourtLineSize
        centerCourtLineNode.position = CGPoint.zero
        anchorNode.addChild(centerCourtLineNode)
    }
    
    func drawCenterTopQuadrantA() {
        //MARK: centercourt line
        let quad = SKSpriteNode()
        let centerCourtLineSize = CGSize(width:centerWidth * 2 - 96, height: 4)
        let centerLineBody = SKPhysicsBody(rectangleOf: centerCourtLineSize)
        quad.color = .clear
        quad.alpha = 0.1
        quad.name = "TopQuadA"
        quad.physicsBody = centerLineBody
        quad.physicsBody?.contactTestBitMask = ballCategory
        quad.physicsBody?.categoryBitMask = midFieldCategory
        quad.physicsBody?.collisionBitMask = midFieldCategory + ballCategory
        quad.physicsBody?.isDynamic = false
        quad.physicsBody?.affectedByGravity = false
        quad.size = centerCourtLineSize
        quad.position = CGPoint(x: 0, y: centerWidth + 140 )
        anchorNode.addChild(quad)
    }
    
    func drawCenterTopQuadrantB() {
        //MARK: centercourt line
        let quad = SKSpriteNode()
        let centerCourtLineSize = CGSize(width:centerWidth * 2 - 96, height: 4)
        let centerLineBody = SKPhysicsBody(rectangleOf: centerCourtLineSize)
        quad.color = .clear
        quad.name = "TopQuadB"
        quad.physicsBody = centerLineBody
        quad.physicsBody?.contactTestBitMask = ballCategory
        quad.physicsBody?.categoryBitMask = midFieldCategory
        quad.physicsBody?.collisionBitMask = midFieldCategory + ballCategory
        quad.physicsBody?.isDynamic = false
        quad.physicsBody?.affectedByGravity = false
        quad.size = centerCourtLineSize
        quad.position = CGPoint(x: 0, y: centerWidth - 100 )
        anchorNode.addChild(quad)
    }
    
    func drawCenterBottomQuadrantA() {
        //MARK: centercourt line
        let quad = SKSpriteNode()
        let centerCourtLineSize = CGSize(width:centerWidth * 2 - 96, height: 4)
        let centerLineBody = SKPhysicsBody(rectangleOf: centerCourtLineSize)
        quad.color = .clear
        quad.name = "BtmQuadA"
        quad.physicsBody = centerLineBody
        quad.physicsBody?.contactTestBitMask = ballCategory
        quad.physicsBody?.categoryBitMask = midFieldCategory
        quad.physicsBody?.collisionBitMask = midFieldCategory + ballCategory
        quad.physicsBody?.isDynamic = false
        quad.physicsBody?.affectedByGravity = false
        quad.size = centerCourtLineSize
        quad.position = CGPoint(x: 0, y: -centerWidth + 140)
        anchorNode.addChild(quad)
    }
    
    func drawCenterBottomQuadrantB() {
        //MARK: centercourt line
        let quad = SKSpriteNode()
        let centerCourtLineSize = CGSize(width:centerWidth * 2 - 96, height: 4)
        let centerLineBody = SKPhysicsBody(rectangleOf: centerCourtLineSize)
        quad.color = .clear
        quad.name = "BtmQuadB"
        quad.physicsBody = centerLineBody
        quad.physicsBody?.contactTestBitMask = ballCategory
        quad.physicsBody?.categoryBitMask = midFieldCategory
        quad.physicsBody?.collisionBitMask = midFieldCategory + ballCategory
        quad.physicsBody?.isDynamic = false
        quad.physicsBody?.affectedByGravity = false
        quad.size = centerCourtLineSize
        quad.position = CGPoint(x: 0, y: -centerWidth - 100)
        anchorNode.addChild(quad)
    }
}
