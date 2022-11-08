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
        let rotateAction = SKAction.rotate(byAngle: .pi * CGFloat(swapper ? 1 : -1), duration: 2)
        
        if firstBody.node?.name == "ball" {
            firstBody.node?.run(rotateAction)
            firstBody.node?.run(rotateAction)
        } else if secondBody.node?.name == "ball" {
            secondBody.node?.run(rotateAction)
            secondBody.node?.run(rotateAction)
        }
        
        switch catMask {
            
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
            
            if settings.sound && ballNode.name == "ball" { run(wallSound) }
            
            if ballNode.name != "powerball" || ballNode.name != "ball" { return }
                        
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
            
            let a = SKAction.fadeAlpha(to: 0, duration: 0.125)
            let b = SKAction.wait(forDuration: 0.125)
            let c = SKAction.removeFromParent()
            
            if let ball = firstBody.node {
                ball.run(SKAction.sequence([a,b,c]))
            }
            
            if settings.sound { run(goalSound) }
            
            if gameLives > 0 {
                gameLives -= 1
                //livesLabel.text = String(gameLives)
                let puck = Global.shared.gameBall[settings.puck]
                livesLabel.text = String(repeating: puck, count: gameLives)
            }
            
            //lives to come
            if gameLives > 0 {
                addPuck()
            }
            
            
            if gameLives < 0 {
                gameLives = 0
                //livesLabel.text = String(gameLives)
                livesLabel.text = ""
            }
            
            if gameLives == 0 && gameOver == nil {
                gameOver = true
                timer.invalidate()
                
                removePowerBall()
                
                let getReadyLabel = SKLabelNode(fontNamed:"emulogic")
                
                let decay1 = SKAction.wait(forDuration: 1.0)
                let decay2 = SKAction.wait(forDuration: 2.0)
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
                
                anchorNode.run(SKAction.sequence([decay1,gameOverCode,decay2,runcode]))
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
