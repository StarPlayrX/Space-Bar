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
        centerCourtLineNode.name = "centercourt"
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
