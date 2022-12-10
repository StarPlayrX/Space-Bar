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
    
    var textLabel: SKLabelNode = SKLabelNode(fontNamed: "CourierNeue")
    var textLabel2: SKLabelNode = SKLabelNode(fontNamed: "CourierNeue")
    
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
                        if let scene = SKScene(fileNamed: "GameMenu") {
                            
                            //sceneNode.entities = scene.entities
                            //sceneNode.graphs = scene.graphs
                            scene.scaleMode = .aspectFit
                            
                            // Present the scene
                            if let view = self.view as SKView? {
                                scene.speed = 1.0
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
                                view.presentScene(scene)
                            }
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
        
        
        let spacer = CGFloat(20)
        let fontsize = CGFloat(26)

        let topTwenty: SKLabelNode = SKLabelNode(fontNamed: "emulogic")
        let playerRank: SKLabelNode = SKLabelNode(fontNamed: "Helvetica-Bold")
        let playerLabel: SKLabelNode = SKLabelNode(fontNamed: "Helvetica-Bold")
        let playerScore: SKLabelNode = SKLabelNode(fontNamed: "Helvetica-Bold")
        let playerStart: SKLabelNode = SKLabelNode(fontNamed: "Helvetica-Bold")
        let playerStop: SKLabelNode = SKLabelNode(fontNamed: "Helvetica-Bold")

        if let hiScorePos = scene?.childNode(withName: "leaderboard")?.position {
            playerRank.position.y = hiScorePos.y - spacer
            playerRank.position.x = -340
            playerRank.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            playerRank.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
            playerRank.alpha = 1.0
            playerRank.text = "Rank"
            playerRank.fontSize = fontsize - 1
            playerRank.fontColor = .systemBlue
            addChild(playerRank)
            
            playerLabel.position.y = hiScorePos.y - spacer
            playerLabel.position.x = -255
            playerLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            playerLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
            playerLabel.alpha = 1.0
            playerLabel.text = "Player"
            playerLabel.fontSize = fontsize
            playerLabel.fontColor = .systemBlue
            addChild(playerLabel)
            
            playerScore.position.y = hiScorePos.y - spacer
            playerScore.position.x = 30
            playerScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            playerScore.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
            playerScore.alpha = 1.0
            playerScore.text = "Score"
            playerScore.fontSize = fontsize - 1
            playerScore.fontColor = .systemBlue
            addChild(playerScore)
            
            playerStart.position.y = hiScorePos.y - spacer
            playerStart.position.x = 180
            playerStart.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            playerStart.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
            playerStart.alpha = 1.0
            playerStart.text = "Start"
            playerStart.fontSize = fontsize - 1
            playerStart.fontColor = .systemBlue
            addChild(playerStart)

            playerStop.position.y = hiScorePos.y - spacer
            playerStop.position.x = 275
            playerStop.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            playerStop.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
            playerStop.alpha = 1.0
            playerStop.text = "End"
            playerStop.fontSize = fontsize - 1
            playerStop.fontColor = .systemBlue
            
            addChild(playerStop)
        }

        
        for i in 0..<leaderBoard.count {
            let v = CGFloat(i * 50 + 50)
            if let hiScorePos = scene?.childNode(withName: "leaderboard")?.position {
                
                let topTwenty: SKLabelNode = SKLabelNode(fontNamed: "emulogic")
                let playerRank: SKLabelNode = SKLabelNode(fontNamed: "Helvetica")
                let playerLabel: SKLabelNode = SKLabelNode(fontNamed: "Helvetica")
                let playerScore: SKLabelNode = SKLabelNode(fontNamed: "Helvetica")
                let playerStart: SKLabelNode = SKLabelNode(fontNamed: "Helvetica")
                let playerStop: SKLabelNode = SKLabelNode(fontNamed: "Helvetica")
        
                playerRank.position.y = hiScorePos.y - spacer - v
                playerRank.position.x = -340
                playerRank.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
                playerRank.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
                playerRank.alpha = 1.0
                playerRank.text = "\(i + 1)."
                playerRank.fontSize = fontsize
                playerRank.fontColor = .white
                addChild(playerRank)
                
                playerLabel.position.y = hiScorePos.y - spacer - v
                playerLabel.position.x = -255
                playerLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
                playerLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
                playerLabel.alpha = 1.0
                
                var player = String(leaderBoard[i].playerName.prefix(20))
                player = player.replacingOccurrences(of: "_", with: " ")
                player = player.replacingOccurrences(of: "%20", with: " ")

                playerLabel.text = player
                playerLabel.fontSize = fontsize
                playerLabel.fontColor = .white
                addChild(playerLabel)
                
                playerScore.position.y = hiScorePos.y - spacer - v
                playerScore.position.x = 30
                playerScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
                playerScore.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
                playerScore.alpha = 1.0
                playerScore.text = String("\(leaderBoard[i].score)".prefix(6))
                playerScore.fontSize = fontsize
                playerScore.fontColor = .white
                addChild(playerScore)
                
                playerStart.position.y = hiScorePos.y - spacer - v
                playerStart.position.x = 180
                playerStart.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
                playerStart.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
                playerStart.alpha = 1.0
                playerStart.text = "\(leaderBoard[i].start)"
                playerStart.fontSize = fontsize
                playerStart.fontColor = .white
                addChild(playerStart)

                playerStop.position.y = hiScorePos.y - spacer - v
                playerStop.position.x = 275
                playerStop.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
                playerStop.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
                playerStop.alpha = 1.0
                playerStop.text = "\(leaderBoard[i].stop)"
                playerStop.fontSize = fontsize
                playerStop.fontColor = .white
                
                addChild(playerStop)
            }
        }
    }
    
}
