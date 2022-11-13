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
            let _ = contact.bodyB.node
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
        swapper.toggle()
        let rotateAction = SKAction.rotate(byAngle: .pi * CGFloat(swapper ? 1 : -1), duration: 4)
        
        let rotationTestA = firstBody.node?.name == "ball" || firstBody.node?.name == "extraball" || firstBody.node?.name == "fireball"
        let rotationTestB = secondBody.node?.name == "ball" || secondBody.node?.name == "extraball" || secondBody.node?.name == "fireball"

        if rotationTestA {
            firstBody.node?.run(rotateAction)
        }

        if rotationTestB {
            secondBody.node?.run(rotateAction)
        }
    
        switch catMask {
            
        case fireBallCategory | brickCategory :
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
  
        case powerCategory | brickCategory :
            if settings.sound { run(brickSound) }
            gameScore += 1
            
            scoreLabel.text = String(gameScore)
            if let a = secondBody.node {
                a.removeFromParent()
                checker(firstBody)
            }
            
        case powerCategory | wallCategory, ballCategory | wallCategory:
            guard
                let ballNode = firstBody.node,
                let x = ballNode.physicsBody?.velocity.dx,
                let y = ballNode.physicsBody?.velocity.dy,
                let body = ballNode.physicsBody
            else {
                return
            }
            
            if settings.sound && ballNode.name == "ball" || ballNode.name == "extraball" { run(wallSound) }
            
            if ballNode.name != "fireball" || ballNode.name != "ball" || ballNode.name != "extraball" { return }
                        
            let absTotal = abs(x) + abs(y)
            
            if absTotal <= initialVelocity * ratio {
                booster(body, boost, initialVelocity)
            } else if absTotal > initialVelocity + differentiator {
                booster(body, -boost, initialVelocity + differentiator)
            }
            
        case ballCategory | midFieldCategory :
            ballCounter = ballTimeOut
        case ballCategory | goalCategory:
            ballCounter = ballTimeOut
            
            guard let name = firstBody.node?.name else { return }
            
            if let a = firstBody.node {
                a.removeFromParent()
            }
            
            if settings.sound { run(goalSound) }
            
            if gameLives > 0 {
                gameLives -= 1
                let puck = Global.shared.gameBall[settings.puck]
                livesLabel.text = String(repeating: puck + "\u{2005}", count: gameLives > 0 ? gameLives - 1 : 0)
            }
            
            if gameLives > 0 && name != "extraball" {
                addPuck()
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
        default:
            break
        }
        
        setHighScore()
    }
}
