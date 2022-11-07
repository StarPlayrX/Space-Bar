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
        for removePowerball in anchorNode.children {
            if let name = removePowerball.name, name.contains("ball") {
                removePowerball.removeFromParent()
            }
        }
        
        space?.removeAllChildren()
        space?.removeFromParent()
        space?.removeAllActions()
        space = nil
        
        settings.currentlevel += 1
        settings.currentlevel %= Global.shared.levels.count
        
        if gameLives < 6 {
            gameLives += 1
        }
        
        //livesLabel.text = String(gameLives)
        let puck = Global.shared.gameBall[settings.puck]
        livesLabel.text = String(repeating: puck, count: gameLives)
        levelLabel.text = String(settings.currentlevel + 1)
        scoreLabel.text = String(gameScore)
        setHighScore()
        appSettings.saveUserDefaults()
        drawLevel()
        
        let getReadyLabel = SKLabelNode(fontNamed:"emulogic")
        
        let decay1 = SKAction.wait(forDuration: 3.0)
        let decay2 = SKAction.wait(forDuration: 1.5)
        let levelUpCode = SKAction.run { [unowned self] in
            
            let getReadyText = "GET READY"
            getReadyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            getReadyLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            getReadyLabel.alpha = 1.0
            getReadyLabel.position = CGPoint(x: 0, y: 0)
            getReadyLabel.zPosition = 50
            getReadyLabel.text = getReadyText
            getReadyLabel.fontSize = 46
            getReadyLabel.alpha = 1.0
            anchorNode.addChild(getReadyLabel)
            
            if let lvl = levelLabel.text, let score = scoreLabel.text, settings.sound, gameLives > 1 {
                try? speech("Level \(lvl). Score \(score). You have \(gameLives) lives. Get Ready!")
            } else if let lvl = levelLabel.text, let score = scoreLabel.text, settings.sound, gameLives == 1 {
                try? speech("Level \(lvl). Score \(score). You have \(gameLives) life remaining. Get Ready!")
            } else if let lvl = levelLabel.text, let score = scoreLabel.text, settings.sound {
                try? speech("Level \(lvl). Score \(score). You have no lives remaining.")
            }
        }
        
        let fadeAlpha = SKAction.fadeOut(withDuration: 0.5)
        let runcode1 = SKAction.run {
            getReadyLabel.run(fadeAlpha)
        }
        
        let runcode2 = SKAction.run { [unowned self] in
            addPuck()
            
            for whatDaPuck in anchorNode.children {
                if let name = whatDaPuck.name, name == "powerball" {
                    whatDaPuck.removeFromParent()
                }
            }
            
            if (settings.currentlevel + 1) % 10 == 0 {
                addPowerBall()
            }
        }
        
        run(SKAction.sequence([levelUpCode,decay1,runcode1,decay2,runcode2]))
    }
}
