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


protocol KeyBoardController {
    func goLeft()
    func goRight()
}

extension GameScene {
    
    func movePaddle(pos: CGPoint, duration: Double) {
        if (pos.x >= g.constraint && pos.x <= frame.width - g.constraint) {
            let action = SKAction.moveTo(x: pos.x, duration: duration)
            paddleNode.run(action)
        }
    }
    
    func moveWithMouse(pos: CGPoint, duration: Double) {
            let action = SKAction.moveTo(x: pos.x + g.constraint + g.constraint / 4, duration: duration)
            paddleNode.run(action)
    }
    
    func touchDown(atPoint pos: CGPoint) {
        movePaddle(pos: pos, duration: 0.1)
    }
    
    func touchMoved(toPoint pos: CGPoint) {
        movePaddle(pos: pos, duration: 0.05)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
    
    @objc func mouseDidMove(_ recognizer: UIHoverGestureRecognizer) {
        // 1
        guard let view = recognizer.view else { return }
        
        let pos = recognizer.location(in: view)
                
        if pos == CGPoint.zero {
            if !g.showCursor {
                g.showCursor = true
                NSCursor.unhide()
            }
        }
  
        switch recognizer.state {
            // 3
        case .began, .changed:
            if g.showCursor {
                g.showCursor = false
                NSCursor.hide()
            }
            
            moveWithMouse(pos: pos, duration: 0.05)
        case .ended:
            if !g.showCursor {
                g.showCursor = true
                NSCursor.unhide()
            }
            
            
            //centerPaddle(pos: pos, duration: 2.0)
        default:
            break
            

        }
    }
}




extension GameViewController: KeyBoardController {

    func goLeft() {
        if gScene?.paddleNode.position.x >= g.constraint + g.constraint / 2  {
            let action = SKAction.moveTo(x: paddleNode.position.x - g.constraint / 2, duration: g.windspeed / g.movement)
            paddleNode.run(action)
        }
    }
    
    func goRight() {
        if paddleNode.position.x <= initialScreenSize.width - g.constraint + g.constraint / 4 {
            let action = SKAction.moveTo(x: paddleNode.position.x + g.constraint / 2, duration: g.windspeed / g.movement)
            paddleNode.run(action)
        }
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for press in presses {
            guard let key = press.key else { continue }
            if key.charactersIgnoringModifiers == UIKeyCommand.inputLeftArrow || key.charactersIgnoringModifiers == "a" {
                paddleNode.removeAction(forKey: g.moveLeft)
            } else if key.charactersIgnoringModifiers == UIKeyCommand.inputRightArrow || key.charactersIgnoringModifiers == "d" {
                paddleNode.removeAction(forKey: g.moveRight)
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
                                
                let wait = SKAction.wait(forDuration: g.windspeed / g.movement)
                let seq = SKAction.sequence([goLeft,wait])
                let rep = SKAction.repeatForever(seq)
                
                paddleNode.run(rep, withKey: g.moveLeft)
                
            }
            
            if key.charactersIgnoringModifiers == UIKeyCommand.inputRightArrow || key.charactersIgnoringModifiers == "d" {
                let goRight = SKAction.run {
                    self.goRight()
                }
                
                let wait = SKAction.wait(forDuration: g.windspeed / g.movement)
                let seq = SKAction.sequence([goRight,wait])
                let rep = SKAction.repeatForever(seq)
                paddleNode.run(rep, withKey: g.moveRight)
            }
            
            if key.charactersIgnoringModifiers == " " {
                print("SPACE")
                
                gScene?.speed = gScene?.speed == 1 ? 0 : 1
                paddleNode.isPaused = paddleNode.isPaused == true ? false : true

            }
        }
    }
}
