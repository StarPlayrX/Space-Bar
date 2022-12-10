//
//  ResetGameBoard.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/7/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func resetGameBoard(lives: Bool) {
        resettingGameBoard = true

        let delay = SKAction.wait(forDuration: 0.5)
        
        let action1 = SKAction.run { [self] in
            removeFireBall(willFade: true)
            removePowerBall()
            removeBall()
        }
      
        let action2 = SKAction.run { [self] in
            removeFireBall(willFade: false)
            space?.removeAllChildren()
            space?.removeFromParent()
            space?.removeAllActions()
            space = nil
            
            settings.currentlevel += 1
            settings.currentlevel %= Global.shared.levels.count
        
            let bonus = bonusRound()
    
            bonusLives(minor: true, major: false, large: true)

            let puck = Global.shared.gameBall[settings.puck]
            livesLabel.text = String(repeating: puck + "\u{2005}", count: gameLives > 0 ? gameLives : 0)
            levelLabel.text = String(settings.currentlevel + 1)
            scoreLabel.text = String(gameScore)
            appSettings.saveUserDefaults()
            drawLevel()
            
            let getReadyLabel = SKLabelNode(fontNamed:"emulogic")
            let delay = SKAction.wait(forDuration: 1.5)
            
            let levelUp = SKAction.run { [self] in
                let getReadyText = "GET READY"
                getReadyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                getReadyLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
                getReadyLabel.alpha = 1.0
                getReadyLabel.position = CGPoint(x: 0, y: 0)
                getReadyLabel.zPosition = 50
                getReadyLabel.text = getReadyText
                getReadyLabel.fontSize = 48
                getReadyLabel.alpha = 1.0
                anchorNode.addChild(getReadyLabel)
                
                if let lvl = levelLabel.text, let score = scoreLabel.text, settings.sound, gameLives > 1 {
                    try? speech("\(bonus) \(lvl). Score \(score). You have \(gameLives) lives. Get Ready!")
                } else if let lvl = levelLabel.text, let score = scoreLabel.text, settings.sound, gameLives == 1 {
                    try? speech("\(bonus) \(lvl). Score \(score). You have \(gameLives) life remaining.")
                } else if let lvl = levelLabel.text, let score = scoreLabel.text, settings.sound {
                    try? speech("\(bonus) \(lvl). Score \(score). You have no lives remaining.")
                }
            }
            
            let fadeAlpha = SKAction.fadeOut(withDuration: 0.5)
            let getReadyFade = SKAction.run {
                getReadyLabel.run(fadeAlpha)
            }
            
            let startLevel = SKAction.run { [self] in
                addPuck()
                livesLabel.text = String(repeating: puck + "\u{2005}", count: gameLives > 0 ? gameLives - 1 : 0)

                for whatDaPuck in anchorNode.children {
                    if let name = whatDaPuck.name, name == "fireball" {
                        whatDaPuck.removeFromParent()
                    }
                }
                getPuck()
                resettingGameBoard = false
            }
            run(SKAction.sequence([delay,levelUp,delay,getReadyFade,delay,startLevel]))
        }
        let seq = SKAction.sequence([action1,delay,action2])
        scene?.run(seq)
        
    }
    
    func bonusRound() -> String {
        if (settings.currentlevel + 1) % 5 == 0 {
            return "Bonus Round"
        }
        
        return "Level"
    }
}
