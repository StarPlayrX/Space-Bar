//
//  DrawEdgeLoop.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/8/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func drawEdgeLoop(_ frame: CGRect) {
        //MARK: border for the paddle, ball and our beer
        let edgeLoop = SKNode()
        edgeLoop.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        edgeLoop.physicsBody?.isDynamic = false
        edgeLoop.physicsBody?.restitution = 0
        edgeLoop.name = "wall"
        edgeLoop.position = CGPoint(x: 0, y: 0)
        edgeLoop.physicsBody?.contactTestBitMask = ballCategory + paddleCategory
        edgeLoop.physicsBody?.allowsRotation = false
        edgeLoop.physicsBody?.categoryBitMask = wallCategory
        anchorNode.addChild(edgeLoop)
    }
}
