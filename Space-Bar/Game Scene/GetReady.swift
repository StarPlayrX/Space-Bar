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
        let getReadyLabel = SKLabelNode(fontNamed:"emulogic")
        let delay = SKAction.wait(forDuration: 1.5)
        let levelUp = SKAction.run { [unowned self] in
            let getReady = "GET READY"
            getReadyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            getReadyLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            getReadyLabel.alpha = 1.0
            getReadyLabel.position = CGPoint(x: 0, y: 0)
            getReadyLabel.zPosition = 50
            getReadyLabel.text = getReady
            getReadyLabel.fontSize = 46
            getReadyLabel.alpha = 1.0
            anchorNode.addChild(getReadyLabel)
            
            if let lvl = levelLabel.text, let score = scoreLabel.text, score == "0", settings.sound {
                try? speech("Level \(lvl). You have \(gameLives) lives. Get Ready!")
            }
        }
        
        let fadeAlpha = SKAction.fadeOut(withDuration: 0.5)
        let showGetReady = SKAction.run {
            getReadyLabel.run(fadeAlpha)
        }
        
        let startGame = SKAction.run { [unowned self] in
            addPuck()
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                self.ballCounter -= 1
                
                if self.ballCounter < 0 {
                    self.ballCounter = self.ballTimeOut
                    self.addPuck()
                }
            }
            
            if (settings.currentlevel + 1) % 10 == 0 {
                addPowerBall()
            }
        }
        run(SKAction.sequence([levelUp,delay,showGetReady,delay,startGame]))
    }
}
