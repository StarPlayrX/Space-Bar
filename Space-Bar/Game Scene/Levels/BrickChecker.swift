//
//  BrickChecker.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/7/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit

var resettingGameBoard = false

extension GameScene {
    func checker(_ firstBody: SKPhysicsBody) {
        
        if resettingGameBoard { return }
        
        // There are two mysterious "bricks" that do not seem to exist
        if let count = space?.children.count, count - 1 <= 0  {
            
            let a = SKAction.fadeAlpha(to: 0, duration: 0.25)
            let b = SKAction.removeFromParent()
            let c = SKAction.wait(forDuration: 0.5)
            let d = SKAction.run { [unowned self] in
                if !resettingGameBoard {
                    resettingGameBoard = true
                    resetGameBoard(lives: true)
                }
            }
            
            if let ball = firstBody.node {
                ball.run(SKAction.sequence([a,b]))
            }
            
            run(SKAction.sequence([c,d]))
        }
    }
}
