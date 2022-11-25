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

extension GameScene {
    func movePaddle(pos: CGPoint, duration: Double) {
        if (pos.x >= g.constraint && pos.x <= frame.width - g.constraint) {
            let action = SKAction.moveTo(x: pos.x, duration: duration)
            paddleNode.run(action)
        }
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
}

extension GameScene {
    func moveWithMouse(pos: CGPoint, duration: Double) {
        guard
            let size = paddleNode.texture?.size()
        else {
            return
        }
        
        let a = size.width
        let b = CGFloat(8)
        let c = CGFloat(2)
        
        let constraint = (a + b) / c
        
        let action = SKAction.moveTo(x: pos.x + constraint, duration: duration)
        paddleNode.run(action)
        
        if pos.x >= frame.width - a * c && pos.x <= frame.width - constraint {
            let action = SKAction.moveTo(x: frame.width - constraint, duration: duration)
            let wait = SKAction.wait(forDuration: duration)
            let seq = SKAction.sequence([action,wait])
            paddleNode.run(seq)
        } else if pos.x <= 30 {
            let action = SKAction.moveTo(x: constraint, duration: duration)
            let wait = SKAction.wait(forDuration: duration)
            let seq = SKAction.sequence([action,wait])
            paddleNode.run(seq)
        }
    }
    
    @objc func mouseDidMove(_ recognizer: UIHoverGestureRecognizer) {
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
        default:
            break
        }
    }
}





