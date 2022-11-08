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
        let centerCourtNode = SKSpriteNode()
        let centerCourtTexture = SKTexture(imageNamed: "centercourt")
        centerCourtNode.texture = centerCourtTexture
        centerCourtNode.size = centerCourtTexture.size()
        centerCourtNode.position = CGPoint(x:0,y:0)
        anchorNode.addChild(centerCourtNode)
        
        //centercourt line
        let centerCourtLineNode = SKSpriteNode()
        let centerCourtLineSize = CGSize(width:centerWidth * 2 - 64, height: 4)
        let centerCourtLineTexture = SKTexture(imageNamed: "centerline")
        centerCourtLineNode.texture = centerCourtLineTexture
        let centerLineBody = SKPhysicsBody(rectangleOf: centerCourtLineSize)
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
