//
//  Keyboard.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/25/22.
//

import Foundation
import SpriteKit

#if targetEnvironment(macCatalyst)
extension GameScene: GameSceneDelegate {
    func removeLeft() {
        paddleNode.removeAction(forKey: g.moveLeft)
    }
    
    func removeRight() {
        paddleNode.removeAction(forKey: g.moveRight)
    }
        
    func goLeft() {
        if paddleNode.position.x >= (paddle / center) + xOffset {
            let action = SKAction.moveTo(x: paddleNode.position.x - xOffset, duration: 0.05)
            paddleNode.run(action)
        }
    }
    
    func goRight() {
        if paddleNode.position.x <= frame.width - (paddle / center) - xOffset  {
            let action = SKAction.moveTo(x: paddleNode.position.x + xOffset, duration: 0.05)
            paddleNode.run(action)
        }
    }

    func moveLeft() {
        let goLeft = SKAction.run {
            self.goLeft()
        }
        
        let wait = SKAction.wait(forDuration: 0.05)
        let seq = SKAction.sequence([goLeft,wait])
        let rep = SKAction.repeatForever(seq)
        
        paddleNode.run(rep, withKey: g.moveLeft)
    }
    
    func moveRight() {
        let goRight = SKAction.run {
            self.goRight()
        }
        
        let wait = SKAction.wait(forDuration: 0.05)
        let seq = SKAction.sequence([goRight,wait])
        let rep = SKAction.repeatForever(seq)
        paddleNode.run(rep, withKey: g.moveRight)
    }
    
    func playPause() {
        // For some reason still have to use a Global here for gScene. Odd, doesn't run correctly using the local
        GameScene.shared.isPaused.toggle()
        GameScene.shared.speed = GameScene.shared.isPaused ? 0 : 1
    }
}

extension GameViewController {
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for press in presses {
            guard let key = press.key else { continue }
            if key.charactersIgnoringModifiers == UIKeyCommand.inputLeftArrow || key.charactersIgnoringModifiers == "a" {
                GameScene.shared.gameSceneDelegate?.removeLeft()
            } else if key.charactersIgnoringModifiers == UIKeyCommand.inputRightArrow || key.charactersIgnoringModifiers == "d" {
                GameScene.shared.gameSceneDelegate?.removeRight()
            }
        }
    }
    
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for press in presses {
            guard let key = press.key else { continue }
            if key.charactersIgnoringModifiers == UIKeyCommand.inputLeftArrow || key.charactersIgnoringModifiers == "a" {
                GameScene.shared.gameSceneDelegate?.moveLeft()
            }
            
            if key.charactersIgnoringModifiers == UIKeyCommand.inputRightArrow || key.charactersIgnoringModifiers == "d" {
                GameScene.shared.gameSceneDelegate?.moveRight()
            }
            
            if key.charactersIgnoringModifiers == " " {
                GameScene().gameSceneDelegate?.playPause()
            }
        }
    }
}
#endif
