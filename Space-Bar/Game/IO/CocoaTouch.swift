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
        super.touchesBegan(touches as Set<UITouch>, with: event)
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if let name = touchedNode.name, name == "pause" {
                playPause()
            } else {
                touchDown(atPoint: touch.location(in: self))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
}

extension GameScene: Arrow {
    func unhide() {
        g.showCursor = true
        #if targetEnvironment(macCatalyst)
        NSCursor.unhide()
        #endif
    }
    
    func hide() {
        g.showCursor = false
        #if targetEnvironment(macCatalyst)
        NSCursor.hide()
        #endif
    }

    func moveWithMouse(pos: CGPoint, duration: Double) {

        var xScale = (( widthiOS - paddle / center - rightBorder ) / windowWidth ) * pos.x
        
        if xScale < paddle / center + leftBorder {
            xScale = paddle / center + leftBorder
        }
        
        let action = SKAction.moveTo(x: xScale, duration: duration)
        paddleNode.run(action)
    }
    
    @available(iOS 13.0, *)
    @objc func mouseDidMove(_ recognizer: UIHoverGestureRecognizer) {
        guard let view = recognizer.view else { return }
        
        let pos = recognizer.location(in: view)

        if pos == CGPoint.zero {
            if !g.showCursor {
                unhide()
            }
        }

        switch recognizer.state {
            
        case .began, .changed:
            if g.showCursor && g.runningGame {
                hide()
            }
            
            moveWithMouse(pos: pos, duration: 0.05)
        case .ended:
            if !g.showCursor {
                unhide()
            }
        default:
            break
        }
    }
}
