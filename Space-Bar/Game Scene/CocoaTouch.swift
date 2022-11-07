//
//  CocoaTouch.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/7/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func touchDown(atPoint pos : CGPoint) {
        let constraint = CGFloat(64)
        if (pos.x >= constraint && pos.x <= frame.width - constraint) {
            let action = SKAction.moveTo(x: pos.x, duration: 0.002)
            paddleNode?.run(action)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        let constraint = CGFloat(64)
        if (pos.x >= constraint && pos.x <= frame.width - constraint) {
            let action = SKAction.moveTo(x: pos.x, duration: 0.002)
            paddleNode?.run(action)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
}
