//
//  Keyboard.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/25/22.
//

import Foundation
import SpriteKit

extension GameScene: GameSceneDelegate {
    func removeLeft() {
        paddleNode.removeAction(forKey: g.moveLeft)
    }
    
    func removeRight() {
        paddleNode.removeAction(forKey: g.moveRight)
    }
        
    func goLeft() {
        if paddleNode.position.x >= (paddle / 2) + xOffset  {
            let action = SKAction.moveTo(x: paddleNode.position.x - xOffset, duration: xTimer)
            paddleNode.run(action)
        }
    }
    
    func goRight() {
        if paddleNode.position.x <= frame.width - paddle - xOffset * 2 {
            let action = SKAction.moveTo(x: paddleNode.position.x + xOffset, duration: xTimer)
            paddleNode.run(action)
        }
    }

    func moveLeft() {
        let goLeft = SKAction.run {
            self.goLeft()
        }
        
        let wait = SKAction.wait(forDuration: xTimer)
        let seq = SKAction.sequence([goLeft,wait])
        let rep = SKAction.repeatForever(seq)
        
        paddleNode.run(rep, withKey: g.moveLeft)
    }
    
    func moveRight() {
        let goRight = SKAction.run {
            self.goRight()
        }
        
        let wait = SKAction.wait(forDuration: xTimer)
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
            
            switch key {
                case let k where k.charactersIgnoringModifiers == UIKeyCommand.inputLeftArrow || k.charactersIgnoringModifiers == "a":
            
                if MoveState.shared.moveLeft {
                    gameSceneDelegate?.removeLeft()
                    MoveState.shared.moveLeft = false
                }
                
                case let k where k.charactersIgnoringModifiers == UIKeyCommand.inputRightArrow || k.charactersIgnoringModifiers == "d":
                if MoveState.shared.moveRight {
                    gameSceneDelegate?.removeRight()
                    MoveState.shared.moveRight = false
                }
                
            default:
                MoveState.shared.moveLeft = false
                MoveState.shared.moveRight = false
            }
        }
    }

    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        
        #if targetEnvironment(macCatalyst)
        func resizeWindow(amount: CGFloat) {
            UIApplication.shared.connectedScenes.map { $0 as! UIWindowScene }.forEach { windowScene in
                windowHeight += amount
                windowWidth = windowHeight / 2
                windowScene.sizeRestrictions?.minimumSize = CGSize(width: windowWidth, height: windowHeight)
                windowScene.sizeRestrictions?.maximumSize = CGSize(width: windowWidth, height: windowHeight)
                settings.height = windowHeight
            }
        }
        #endif
            
        for press in presses {
            guard let key = press.key else { continue }
            
            switch key {
                case let k where k.charactersIgnoringModifiers == UIKeyCommand.inputLeftArrow || k.charactersIgnoringModifiers == "a":
                
                if MoveState.shared.moveRight {
                    gameSceneDelegate?.removeRight()
                    MoveState.shared.moveRight = false
                }
                
                gameSceneDelegate?.moveLeft()
                MoveState.shared.moveLeft = true
                
                case let k where k.charactersIgnoringModifiers == UIKeyCommand.inputRightArrow || k.charactersIgnoringModifiers == "d":
                
                if MoveState.shared.moveLeft {
                    gameSceneDelegate?.removeLeft()
                    MoveState.shared.moveLeft = false
                }

                gameSceneDelegate?.moveRight()
                MoveState.shared.moveRight = true
                
                case let k where k.charactersIgnoringModifiers == " ":
                gameSceneDelegate?.playPause()
        
            #if targetEnvironment(macCatalyst)
                case let k where k.charactersIgnoringModifiers == UIKeyCommand.inputUpArrow || k.charactersIgnoringModifiers == "w":
                resizeWindow(amount: 2)
                case let k where k.charactersIgnoringModifiers == UIKeyCommand.inputDownArrow || k.charactersIgnoringModifiers == "s":
                resizeWindow(amount: -2)
            #endif

            default:
                
                if MoveState.shared.moveLeft {
                    gameSceneDelegate?.removeLeft()
                    MoveState.shared.moveLeft = false
                }
                
                if MoveState.shared.moveRight {
                    gameSceneDelegate?.removeRight()
                    MoveState.shared.moveRight = false
                }
            }
        }
    }
}
