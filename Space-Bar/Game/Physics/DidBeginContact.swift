//
//  DidBeginContact.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/7/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func didBegin(_ contact: SKPhysicsContact) {
        guard
            let _ = contact.bodyA.node,
            let _ = contact.bodyB.node,
            let name1 = contact.bodyA.node?.name,
            let name2 = contact.bodyA.node?.name
        else {
            return
        }
        
        // Defaults for bodyA and BodyB
        var firstBody = contact.bodyB
        var secondBody = contact.bodyA
        
        if contact.bodyB.categoryBitMask > contact.bodyA.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        
        let catMask = firstBody.categoryBitMask | secondBody.categoryBitMask
        
        if name1.contains("ball") {
            swapper2.toggle()
            let rotateAction = SKAction.rotate(byAngle: .pi * CGFloat(swapper2 ? 1 : -1), duration: 2)
            firstBody.node?.run(rotateAction)
        }

        if name2.contains("ball") {
            swapper3.toggle()
            let rotateAction = SKAction.rotate(byAngle: .pi * CGFloat(swapper3 ? 1 : -1), duration: 2)
            secondBody.node?.run(rotateAction)
        }
    
        switch catMask {
        
        case powerCategory | wallCategory, ballCategory | wallCategory:
            if settings.sound { run(wallSound) }
        case ballCategory | midFieldCategory :
            ballCounter = ballTimeOut
        case fireBallCategory | brickCategory:
            gameScore += 2
            scoreLabel.text = String(gameScore)
            if let a = secondBody.node {
                a.removeFromParent()
                checker(firstBody)
            }
        case powerCategory | brickCategory:
            if settings.sound { run(brickSound) }
            gameScore += 1
            scoreLabel.text = String(gameScore)
            if let a = secondBody.node {
                a.removeFromParent()
                checker(firstBody)
            }
        case ballCategory | brickCategory :
            ballCounter = ballTimeOut
            if settings.sound { run(brickSound) }
            gameScore += 1
            scoreLabel.text = String(gameScore)
            if let a = secondBody.node {
                a.removeFromParent()
                checker(firstBody)
            }
        case ballCategory | goalCategory:
            if let a = firstBody.node, let name = firstBody.node?.name {
                a.physicsBody = nil
                a.name = ""
                a.removeFromParent()

                if name == "extraball" {
                    if gameLives > 0 {
                        return
                    }
                }
            } else {
                return
            }
            
            ballCounter = ballTimeOut
            
            if gameLives > 0 {
                gameLives -= 1
                if settings.sound { run(goalSound) }
                let puck = Global.shared.gameBall[settings.puck]
                livesLabel.text = String(repeating: puck + "\u{2005}", count: gameLives > 0 ? gameLives - 1 : 0)
            }
            
            if gameLives > 0 && name != "extraball" {
                addPuck()
                
                if (settings.currentlevel + 1) % 20 == 0 {
                    addExtraBall()
                }
                return
            }
            
            if gameLives < 0 {
                gameLives = 0
                livesLabel.text = ""
            }
            
            if gameLives == 0 && gameOver == nil {
                gameOver = true
                timer.invalidate()
                let action1 = SKAction.wait(forDuration: 1.0)
                
                let action2 = SKAction.run { [self] in
                    removeFireBall(willFade: true)
                    removePowerBall()
                    removeBall()
                }
                
                let action3 = SKAction.run { [self] in
                    removeFireBall(willFade: false)

                    let getReadyLabel = SKLabelNode(fontNamed:"emulogic")
                    
                    let wait1 = SKAction.wait(forDuration: 0.5)
                    let wait2 = SKAction.wait(forDuration: 1.0)
                    let gameOverCode = SKAction.run { [unowned self] in
                        g.runningGame = false
                        let getReadyText = "GAME OVER"
                        getReadyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                        getReadyLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
                        getReadyLabel.alpha = 1.0
                        getReadyLabel.position = CGPoint(x: 0, y: 0)
                        getReadyLabel.zPosition = 50
                        getReadyLabel.text = getReadyText
                        getReadyLabel.fontSize = 46
                        getReadyLabel.alpha = 1.0
                        anchorNode.addChild(getReadyLabel)
                        
                        if let score = scoreLabel.text, Int(score) ?? 0 > 1, settings.sound {
                            try? speech("Game Over. You scored \(score) points.")
                        } else if let score = scoreLabel.text, Int(score) ?? 0 == 1, settings.sound {
                            try? speech("Game Over. You scored one point.")
                        } else if settings.sound {
                            try? speech("Game Over. You managed to score zero points. Try watching Ted Lassoe.")
                        }
                    }
                    
                    let runcode = SKAction.run {
                        NotificationCenter.default.post(name: Notification.Name("loadGameView"), object: nil)
                    }
                    
                    self.anchorNode.run(SKAction.sequence([wait1,gameOverCode,wait2,runcode]))
                }
          
                let seq = SKAction.sequence([action2, action1, action3])
                scene?.run(seq)
            }
        case powerCategory | paddleCategory:
            if settings.sound { run(paddleSound) }
            scoreLabel.text = String(gameScore)
            
        case ballCategory | paddleCategory:
            ballCounter = ballTimeOut
            if settings.sound { run(paddleSound) }
            scoreLabel.text = String(gameScore)
            
            if let b = secondBody.node {

                let dy = CGFloat.random(in:  0...1)

                b.physicsBody?.applyImpulse(CGVector(dx: 0, dy: dy))
            }
        default:
            break
        }
        
        setHighScore()
    }
}
