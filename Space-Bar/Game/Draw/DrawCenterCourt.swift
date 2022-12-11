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
        centerCourtLineNode.size = centerCourtLineSize
        centerCourtLineNode.position = CGPoint.zero
        anchorNode.addChild(centerCourtLineNode)
    }
    
    func drawCenterMidQuadrant() {
        let midQuad = SKSpriteNode()
        let centerCourtLineSize = CGSize(width:centerWidth * 2 - 192, height: 4)
        let centerLineBody = SKPhysicsBody(rectangleOf: centerCourtLineSize)
        midQuad.color = .clear
        midQuad.alpha = 0.5
        midQuad.name = "CenterLine"
        midQuad.physicsBody = centerLineBody
        midQuad.physicsBody?.contactTestBitMask = ballCategory
        midQuad.physicsBody?.categoryBitMask = midFieldCategory
        midQuad.physicsBody?.collisionBitMask = midFieldCategory + ballCategory
        midQuad.physicsBody?.isDynamic = false
        midQuad.physicsBody?.affectedByGravity = false
        midQuad.size = centerCourtLineSize
        midQuad.position = CGPoint.zero
        anchorNode.addChild(midQuad)
    }
    
    func drawCenterTopQuadrantA() {
        let quad = SKSpriteNode()
        let centerCourtLineSize = CGSize(width:centerWidth * 2 - 192, height: 4)
        let centerLineBody = SKPhysicsBody(rectangleOf: centerCourtLineSize)
        quad.name = "TopQuadA"
        quad.color = .clear
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
        let quad = SKSpriteNode()
        let centerCourtLineSize = CGSize(width:centerWidth * 2 - 192, height: 4)
        let centerLineBody = SKPhysicsBody(rectangleOf: centerCourtLineSize)
        quad.name = "TopQuadB"
        quad.color = .clear
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
        let quad = SKSpriteNode()
        let centerCourtLineSize = CGSize(width:centerWidth * 2 - 192, height: 4)
        let centerLineBody = SKPhysicsBody(rectangleOf: centerCourtLineSize)
        quad.name = "BtmQuadA"
        quad.color = .clear
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
        let quad = SKSpriteNode()
        let centerCourtLineSize = CGSize(width:centerWidth * 2 - 192, height: 4)
        let centerLineBody = SKPhysicsBody(rectangleOf: centerCourtLineSize)
        quad.name = "BtmQuadB"
        quad.color = .clear
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
