//
//  Keyboard.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/25/22.
//

import Foundation
import SpriteKit

extension GameScene: GameSceneDelegate {
    
    static let shared = GameScene()
    
    func removeLeft() {
        paddleNode.removeAction(forKey: g.moveLeft)
    }
    
    func removeRight() {
        paddleNode.removeAction(forKey: g.moveRight)
    }
        
    func goLeft() {
        if paddleNode.position.x >= (paddle / 2) + xOffset  {
            let action = SKAction.moveTo(x: paddleNode.position.x - xOffset, duration: 0.05)
            paddleNode.run(action)
        }
    }
    
    func goRight() {
        if paddleNode.position.x <= frame.width - paddle - xOffset * 2 {
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
        //MARK: For some reason still have to use a Global here for gScene. Odd, doesn't run correctly using the local
        gScene.isPaused.toggle()
        gScene.speed = gScene.isPaused ? 0 : 1
    }
}

extension GameViewController {
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for press in presses {
            guard let key = press.key else { continue }
            if key.charactersIgnoringModifiers == UIKeyCommand.inputLeftArrow || key.charactersIgnoringModifiers == "a" {
                gameSceneDelegate?.removeLeft()
            } else if key.charactersIgnoringModifiers == UIKeyCommand.inputRightArrow || key.charactersIgnoringModifiers == "d" {
                gameSceneDelegate?.removeRight()
            }
        }
    }
    
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        for press in presses {
            guard let key = press.key else { continue }
            if key.charactersIgnoringModifiers == UIKeyCommand.inputLeftArrow || key.charactersIgnoringModifiers == "a" {
                gameSceneDelegate?.moveLeft()
            }
            
            
            #if targetEnvironment(macCatalyst)
            if key.charactersIgnoringModifiers == UIKeyCommand.inputUpArrow || key.charactersIgnoringModifiers == "w" {
                UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.forEach { windowScene in
                    heightMacOS += 2
                    widthMacOS = heightMacOS / 2
                    
                    windowScene.sizeRestrictions?.minimumSize = CGSize(width: widthMacOS, height: heightMacOS)
                    windowScene.sizeRestrictions?.maximumSize = CGSize(width: widthMacOS, height: heightMacOS)
                    
                    settings.height = heightMacOS
                }
            }
            
            if key.charactersIgnoringModifiers == UIKeyCommand.inputDownArrow || key.charactersIgnoringModifiers == "s" {
                UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.forEach { windowScene in
                    heightMacOS -= 2
                    widthMacOS = heightMacOS / 2
                    
                    windowScene.sizeRestrictions?.minimumSize = CGSize(width: widthMacOS, height: heightMacOS)
                    windowScene.sizeRestrictions?.maximumSize = CGSize(width: widthMacOS, height: heightMacOS)
                    
                    settings.height = heightMacOS
                }
            }
            #endif

            
            if key.charactersIgnoringModifiers == UIKeyCommand.inputLeftArrow || key.charactersIgnoringModifiers == "a" {
                gameSceneDelegate?.moveLeft()
            }
            
            if key.charactersIgnoringModifiers == UIKeyCommand.inputRightArrow || key.charactersIgnoringModifiers == "d" {
                gameSceneDelegate?.moveRight()
            }
            
            if key.charactersIgnoringModifiers == " " {
                gameSceneDelegate?.playPause()
            }
        }
    }
}
