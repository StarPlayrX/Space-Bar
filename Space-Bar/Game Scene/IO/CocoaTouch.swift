//
//  CocoaTouch.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/7/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

var paddleNode = SKSpriteNode() //available to the entire class
let constraint = CGFloat(64)
let windspeed: Double = 0.3
let movement: Double = 10
let moveLeft: String = "moveLeft"
let moveRight: String = "moveRight"

protocol KeyBoardController {
    func goLeft()
    func goRight()
}

extension GameScene {
    func touchDown(atPoint pos: CGPoint) {
        if (pos.x >= constraint && pos.x <= frame.width - constraint) {
            let action = SKAction.moveTo(x: pos.x, duration: windspeed)
            paddleNode.run(action)
        }
    }
    
    func touchMoved(toPoint pos: CGPoint) {
        if (pos.x >= constraint && pos.x <= frame.width - constraint) {
            let action = SKAction.moveTo(x: pos.x, duration: windspeed * 0.01)
            paddleNode.run(action)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
    
}


extension GameViewController: KeyBoardController {

    func goLeft() {
        if paddleNode.position.x >= constraint + constraint / 2  {
            let action = SKAction.moveTo(x: paddleNode.position.x - constraint / 2, duration: windspeed / movement)
            paddleNode.run(action)
        }
    }
    
    func goRight() {
        if paddleNode.position.x <= initialScreenSize.width - constraint + constraint / 4 {
            let action = SKAction.moveTo(x: paddleNode.position.x + constraint / 2, duration: windspeed / movement)
            paddleNode.run(action)
        }
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for press in presses {
            guard let key = press.key else { continue }
            if key.charactersIgnoringModifiers == UIKeyCommand.inputLeftArrow || key.charactersIgnoringModifiers == "a" {
                paddleNode.removeAction(forKey: moveLeft)
            } else if key.charactersIgnoringModifiers == UIKeyCommand.inputRightArrow || key.charactersIgnoringModifiers == "d" {
                paddleNode.removeAction(forKey: moveRight)
            }
        }
    }

 
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for press in presses {
            guard let key = press.key else { continue }
            if key.charactersIgnoringModifiers == UIKeyCommand.inputLeftArrow || key.charactersIgnoringModifiers == "a" {
                
                let goLeft = SKAction.run {
                    self.goLeft()
                }
                
                let wait = SKAction.wait(forDuration: windspeed / movement)
                let seq = SKAction.sequence([goLeft,wait])
                let rep = SKAction.repeatForever(seq)
                
                paddleNode.run(rep, withKey: moveLeft)
                
            } else if key.charactersIgnoringModifiers == UIKeyCommand.inputRightArrow || key.charactersIgnoringModifiers == "d" {
                let goRight = SKAction.run {
                    self.goRight()
                }
                
                let wait = SKAction.wait(forDuration: windspeed / movement)
                let seq = SKAction.sequence([goRight,wait])
                let rep = SKAction.repeatForever(seq)
                paddleNode.run(rep, withKey: moveRight)
            }
        }
    }
}
