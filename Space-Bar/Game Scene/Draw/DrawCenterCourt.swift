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
        //centercourt circle
        
        let centerCourtNode = SKShapeNode(circleOfRadius: centerWidth / 3 + 4) // Size of Circle
        centerCourtNode.strokeColor = .systemRed
        centerCourtNode.lineWidth = 3.0
        centerCourtNode.glowWidth = 1.0
        centerCourtNode.alpha = 0.667
        centerCourtNode.fillColor = SKColor.clear
        //centerCourtNode.size = CGSize(width: 50, height: 50)
        centerCourtNode.position = CGPoint(x:0,y:0)
        anchorNode.addChild(centerCourtNode)
        
        //centercourt line
        let centerCourtLineNode = SKSpriteNode()
        let centerCourtLineSize = CGSize(width:centerWidth * 2 - 64, height: 4)
        let centerLineBody = SKPhysicsBody(rectangleOf: centerCourtLineSize)
        centerCourtLineNode.color = .systemRed
        centerCourtLineNode.alpha = 0.667
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
}