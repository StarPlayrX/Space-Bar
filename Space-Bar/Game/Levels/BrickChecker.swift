//
//  BrickChecker.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/7/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func isLevelCompleted(_ firstBody: SKPhysicsBody) {
        
        if resettingGameBoard { return }
        
        resettingGameBoard = true

        // There are two mysterious "bricks" that do not seem to exist
        if let count = space?.children.count, count - 1 <= 0  {
           
            for whatDaPuck in anchorNode.children {
                if let name = whatDaPuck.name, name == "extraball" {
                    whatDaPuck.removeFromParent()
                    if gameLives < 5 {
                        gameLives += 1
                    }
                }
            }
         
            bonusLives(minor: false, major: true, large: false)

            let a = SKAction.fadeAlpha(to: 0, duration: 0.25)
            let b = SKAction.removeFromParent()
            let c = SKAction.wait(forDuration: 0.5)
            let d = SKAction.run { [self] in
                DispatchQueue.global(qos: .background).async {
                    self.resetGameBoard(lives: true)
                }
            }
            
            if let ball = firstBody.node {
                ball.run(SKAction.sequence([a,b]))
            }
            
            run(SKAction.sequence([c,d]))
        } else {
            resettingGameBoard = false
        }
    }
}
