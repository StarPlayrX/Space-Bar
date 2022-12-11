//
//  GameScene.swift
//  Space-Bar
//
//  Created by Todd Bruss on 10/5/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import SpriteKit
//import GameplayKit

class GameLeader: SKScene {
    override func sceneDidLoad() {
        g.showCursor = true
        g.runningGame = false
        
    #if targetEnvironment(macCatalyst)
        NSCursor.unhide()
    #endif
    }
    
    var keyPressed = false
    
    deinit {
        removeAllActions()
        removeAllChildren()
        removeFromParent()
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches as Set<UITouch>, with: event)
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if let name = touchedNode.name {
                
                if name == "gamemenu" && !keyPressed {
                    if keyPressed { return }
                    keyPressed = true
                    
                    let runcode = SKAction.run { [self] in
                        if let scene = SKScene(fileNamed: "GameMenu"), let view = self.view  {
                            
                            scene.scaleMode = .aspectFit
                            
                            // Present the scene
                            view.showsFPS = false
                            view.showsNodeCount = false
                            view.showsPhysics = false
                            view.showsFields = false
                            view.clearsContextBeforeDrawing = true
                            view.isAsynchronous = true
                            view.ignoresSiblingOrder = true
                            view.clipsToBounds = true
                            view.backgroundColor = SKColor.black
                            view.isMultipleTouchEnabled = false
                            view.presentScene(scene, transition: SKTransition.fade(withDuration: 1.0))
                        }
                    }
                    
                    let fade1 = SKAction.fadeAlpha(to: 0.7, duration:TimeInterval(0.15))
                    let myDecay = SKAction.wait(forDuration: 0.15)
                    let fade2 = SKAction.fadeAlpha(to: 1.0, duration:TimeInterval(0.15))
                    touchedNode.run(SKAction.sequence([fade1,myDecay,fade2,runcode]))
                }
            }
        }
    }
    
    override func didMove(to view: SKView) {        
        g.showCursor = true
        
    #if targetEnvironment(macCatalyst)
        NSCursor.unhide()
    #endif
        
        let spacer = CGFloat(30)
        let fontsize = CGFloat(30)
        let cutoff = Int(22)

        let spceColumn = CGFloat(-3)
        let rankColumn  = CGFloat(-355)
        let rankColumnB = CGFloat(-300)

        let plyrColumn = CGFloat(-270)
        let scorColumn = CGFloat(80)
        let strtColumn = CGFloat(225)
        let stopColumn = CGFloat(310)
        
        let fontName = "Noteworthy-Bold"
        let playerRank: SKLabelNode = SKLabelNode(fontNamed: fontName)
        let playerLabel: SKLabelNode = SKLabelNode(fontNamed: fontName)
        let playerScore: SKLabelNode = SKLabelNode(fontNamed: fontName)
        let playerStart: SKLabelNode = SKLabelNode(fontNamed: fontName)
        let playerStop: SKLabelNode = SKLabelNode(fontNamed: fontName)
        
        var toggleColor = true
        let lightColor   = UIColor(displayP3Red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        let darkColor    = UIColor(displayP3Red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
        
        if let hiScorePos = scene?.childNode(withName: "leaderboard")?.position {
            playerRank.position.y = hiScorePos.y - spacer
            playerRank.position.x = rankColumn + spceColumn * 3
            playerRank.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            playerRank.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
            playerRank.alpha = 1.0
            playerRank.text = "Rank"
            playerRank.fontSize = fontsize
            playerRank.fontColor = .systemBlue
            addChild(playerRank)
            
            playerLabel.position.y = hiScorePos.y - spacer
            playerLabel.position.x = plyrColumn  + spceColumn * 1.5
            playerLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            playerLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
            playerLabel.alpha = 1.0
            playerLabel.text = "Player"
            playerLabel.fontSize = fontsize
            playerLabel.fontColor = .systemBlue
            addChild(playerLabel)
            
            playerScore.position.y = hiScorePos.y - spacer
            playerScore.position.x = scorColumn + spceColumn
            playerScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            playerScore.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
            playerScore.alpha = 1.0
            playerScore.text = "Score"
            playerScore.fontSize = fontsize
            playerScore.fontColor = .systemBlue
            addChild(playerScore)
            
            playerStart.position.y = hiScorePos.y - spacer
            playerStart.position.x = strtColumn + spceColumn * 1.5
            playerStart.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            playerStart.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
            playerStart.alpha = 1.0
            playerStart.text = "Start"
            playerStart.fontSize = fontsize
            playerStart.fontColor = .systemBlue
            addChild(playerStart)

            playerStop.position.y = hiScorePos.y - spacer
            playerStop.position.x = stopColumn + spceColumn * 1.5
            playerStop.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            playerStop.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
            playerStop.alpha = 1.0
            playerStop.text = "End"
            playerStop.fontSize = fontsize
            playerStop.fontColor = .systemBlue
            
            addChild(playerStop)
        }

        
        for i in 0..<leaderBoard.count {
            let v = CGFloat(i * 50 + 50)
            if let hiScorePos = scene?.childNode(withName: "leaderboard")?.position {
                
                let playerRank: SKLabelNode = SKLabelNode(fontNamed: fontName)
                let playerLabel: SKLabelNode = SKLabelNode(fontNamed: fontName)
                let playerScore: SKLabelNode = SKLabelNode(fontNamed: fontName)
                let playerStart: SKLabelNode = SKLabelNode(fontNamed: fontName)
                let playerStop: SKLabelNode = SKLabelNode(fontNamed: fontName)
        
                toggleColor.toggle()
                
                playerRank.position.y = hiScorePos.y - spacer - v
                playerRank.position.x = rankColumnB
                playerRank.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
                playerRank.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
                playerRank.alpha = 1.0
                playerRank.text = "\(i + 1)."
                playerRank.fontSize = fontsize
                playerRank.fontColor = toggleColor ? darkColor : lightColor
                addChild(playerRank)
                
                playerLabel.position.y = hiScorePos.y - spacer - v
                playerLabel.position.x = plyrColumn + spceColumn * 2
                playerLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
                playerLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
                playerLabel.alpha = 1.0
                
                var player = String(leaderBoard[i].playerName.prefix(cutoff))
                player = player.replacingOccurrences(of: "_", with: "")
                player = player.replacingOccurrences(of: "%20", with: "")

                if player.contains("whitemeat") {
                    player = "MaxaMillion"
                }
                
                player = player.replacingOccurrences(of: " ", with: "")

                playerLabel.text = player
                playerLabel.fontSize = fontsize
                playerLabel.fontColor = toggleColor ? darkColor : lightColor

                addChild(playerLabel)
                
                playerScore.position.y = hiScorePos.y - spacer - v
                playerScore.position.x = scorColumn
                playerScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
                playerScore.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
                playerScore.alpha = 1.0
                playerScore.text = String("\(leaderBoard[i].score)".prefix(6))
                playerScore.fontSize = fontsize
                playerScore.fontColor = toggleColor ? darkColor : lightColor

                addChild(playerScore)
                
                playerStart.position.y = hiScorePos.y - spacer - v
                playerStart.position.x = strtColumn
                playerStart.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
                playerStart.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
                playerStart.alpha = 1.0
                playerStart.text = "\(leaderBoard[i].start)"
                playerStart.fontSize = fontsize
                playerStart.fontColor = toggleColor ? darkColor : lightColor

                addChild(playerStart)

                playerStop.position.y = hiScorePos.y - spacer - v
                playerStop.position.x = stopColumn
                playerStop.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
                playerStop.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
                playerStop.alpha = 1.0
                playerStop.text = "\(leaderBoard[i].stop)"
                playerStop.fontSize = fontsize
                playerStop.fontColor = toggleColor ? darkColor : lightColor
                addChild(playerStop)
            }
        }
    }
    
}
