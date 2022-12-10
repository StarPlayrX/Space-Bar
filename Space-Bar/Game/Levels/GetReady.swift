//
//  GetReady.swift (GameStart)
//  Space-Bar
//
//  Created by Todd Bruss on 11/8/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func getReady() {
        g.runningGame = true
        let puck = Global.shared.gameBall[settings.puck]
        livesLabel.text = String(repeating: puck + "\u{2005}", count: gameLives > 0 ? gameLives : 0)
        let getReadyLabel = SKLabelNode(fontNamed:"emulogic")
        let delay = SKAction.wait(forDuration: 1.5)
        let levelUp = SKAction.run { [self] in
            let getReady = "GET READY"
            getReadyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            getReadyLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            getReadyLabel.alpha = 1.0
            getReadyLabel.position = CGPoint.zero
            getReadyLabel.zPosition = 50
            getReadyLabel.text = getReady
            getReadyLabel.fontSize = 48
            getReadyLabel.alpha = 1.0
            anchorNode.addChild(getReadyLabel)
            
            let bonus = bonusRound()
            
            if let lvl = levelLabel.text, let score = scoreLabel.text, score == "0", settings.sound && gameLives > 1 {
                try? speech("\(bonus) \(lvl). You have \(gameLives) lives. Get Ready!")
            } else if let lvl = levelLabel.text, let score = scoreLabel.text, score == "0", settings.sound && gameLives == 1  {
                try? speech("\(bonus) \(lvl). You have \(gameLives) life. Get Ready!")
            }
        }
        
        let fadeAlpha = SKAction.fadeOut(withDuration: 0.5)
        let showGetReady = SKAction.run {
            getReadyLabel.run(fadeAlpha)
        }
        
        let startGame = SKAction.run { [self] in
            addPuck()
            
            livesLabel.text = String(repeating: puck + "\u{2005}", count: gameLives > 0 ? gameLives - 1 : 0)
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timer in
                
                if isPaused {
                    ballCounter = 5
                } else {
                    ballCounter -= 1
                    
                    if ballCounter < 0 {
                        ballCounter = ballTimeOut
                        addPuck()
                    }
                }
            }
            
            getPuck()
        }
        run(SKAction.sequence([levelUp,delay,showGetReady,delay,startGame]))
    }
    
    //MARK: Bonus levels occur 20% of the time
    func getPuck() {
        let bonusLevel = settings.currentlevel + 1
        //MARK: Extra Ball 20, 40, 60, 80, 100
        if bonusLevel % 20 == 0 {
            addExtraBall()
            addPuck(override: true)
            //MARK: Shoot FireBalls 10, 30, 50, 70, 90
        } else if bonusLevel % 10 == 0 {
            for _ in 1...3 {
                self.shootFireBalls()
            }
            //MARK: Tennis Ball 5, 15, 25, 35, 45, 55, 65, 75, 85, 95
        } else if bonusLevel % 5 == 0 {
            addTennisBall()
            
            //Clean up
        } else {
            removeFireBall(willFade: false)
        }
    }
}
