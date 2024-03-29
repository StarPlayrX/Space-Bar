//
//  DidBeginContact.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/7/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

extension GameScene {
    func playSound(action: SKAction) {
        if settings.sound {
            run(action)
        }
    }
    
    func isGameOver() {
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
                let gameOverCode = SKAction.run { [self] in
                    g.runningGame = false
                    let getReadyText = "GAME OVER"
                    getReadyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                    getReadyLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
                    getReadyLabel.alpha = 1.0
                    getReadyLabel.position = CGPoint(x: 0, y: 0)
                    getReadyLabel.zPosition = 50
                    getReadyLabel.text = getReadyText
                    getReadyLabel.fontSize = 48
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
                    self.setHighScore()
                    
                    if let scene = SKScene(fileNamed: "GameMenu"), let view = self.view as SKView? {
                        scene.scaleMode = .aspectFit
                        view.ignoresSiblingOrder = true
                        view.showsFPS = false
                        view.showsNodeCount = false
                        view.isMultipleTouchEnabled = false
                        view.presentScene(scene, transition: SKTransition.crossFade(withDuration: 2.0))
                    }
                }
                
                self.anchorNode.run(SKAction.sequence([wait1,gameOverCode,wait2,runcode]))
            }
            
            let seq = SKAction.sequence([action2, action1, action3])
            scene?.run(seq)
        }
    }
    
    func randomizer(_ secondBody: SKPhysicsBody) {
        if let b = secondBody.node {
            let dy = CGFloat.random(in: -2...2)
            let dx = CGFloat.random(in: -5...5)
            b.physicsBody?.applyImpulse(CGVector(dx: dx, dy: dy))
        }
    }
    
    func ballVsGoal(_ firstBody: SKPhysicsBody) {
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
            playSound(action: goalSound)
            
            gameLives -= 1
            let puck = Global.shared.gameBall[settings.puck]
            livesLabel.text = String(repeating: puck + "\u{2005}", count: gameLives > 0 ? gameLives - 1 : 0)
        }
        if (settings.currentlevel + 1) % 20 == 0 {
            addExtraBall()
            addPuck(override: true)
            return
        } else if gameLives > 0 && name != "extraball" {
            addPuck()
            return
        }
        if gameLives < 0 {
            gameLives = 0
            livesLabel.text = ""
        }
    }
    
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
        case ballCategory | wallCategory:
            playSound(action: wallSound)
            if let name = secondBody.node?.name, name == "middie" {
                randomizer(secondBody)
            }
        case powerCategory | wallCategory:
            playSound(action: wallSound)
            if let name = secondBody.node?.name, name == "middie" {
                randomizer(secondBody)
            }
        case ballCategory | midFieldCategory :
            ballCounter = ballTimeOut
        case fireBallCategory | brickCategory:
            gameScore += 2
            scoreLabel.text = String(gameScore)
            if let a = secondBody.node {
                a.removeFromParent()
                isLevelCompleted(firstBody)
            }
        case powerCategory | brickCategory:
            playSound(action: brickSound)
            gameScore += 1
            scoreLabel.text = String(gameScore)
            if let a = secondBody.node {
                a.removeFromParent()
                isLevelCompleted(firstBody)
            }
        case ballCategory | brickCategory :
            playSound(action: brickSound)
            ballCounter = ballTimeOut
            gameScore += 1
            scoreLabel.text = String(gameScore)
            if let a = secondBody.node {
                a.removeFromParent()
                isLevelCompleted(firstBody)
            }
        case ballCategory | goalCategory:
            ballVsGoal(firstBody)
            isGameOver()
        case powerCategory | paddleCategory:
            playSound(action: paddleSound)
            scoreLabel.text = String(gameScore)
        case ballCategory | paddleCategory:
            playSound(action: paddleSound)
            scoreLabel.text = String(gameScore)
            randomizer(secondBody)
        default:
            break
        }
    }
}
