//
//  ParentalScene.swift
//  Fidget
//
//  Created by StarPlayr on 5/28/17.
//  Copyright © 2019 Todd Bruss. All rights reserved.
//

import SpriteKit
//import AudioToolbox
//import AVFoundation

 let puckArray: Array = ["🤩","🥳","😏","😒","😞","😔","😟","😕"]
 let rotation = [0,45,90.0,135.0,180.0,225.0,270.0,315.0]
 let levelArray = ["😀","😍","😝","🤩","😃","🥰","😜","🥳","😄","😘","🤪","😏","😁","😗","🤨","😒","😆","😙","🧐","😞","😅","😚","🤓","😔","😂","😋","😎","😟","🤣","😛","🥸","😕"]
 let puckTextArray: Array = ["blue","fuchsia","warm red","orange","magenta","bright green","green","purple rain"]
 let insArray: Array = ["🔇","🔊"]
 let insTextArray: Array = ["no sound fx","sound fx"]

class GameMenu: SKScene { //
        
    deinit {
        removeAllActions()
        removeAllChildren()
        removeFromParent()
        print("Game Menu deinit")
    }
    
    var maxpuck = puckArray.count - 1
    var minpuck = 0
    
    var maxins = insArray.count - 1
    var minins = 0
    
    var emojifontsize = CGFloat(150)
    var puckLabel: SKLabelNode = SKLabelNode(fontNamed: "SpaceBarColors")
    var puckTextLabel: SKLabelNode = SKLabelNode(fontNamed: "emulogic")
    
    var insLabel: SKLabelNode = SKLabelNode(fontNamed: "SpaceBarColors")
    var insTextLabel: SKLabelNode = SKLabelNode(fontNamed: "emulogic")
    
    var frtLabel: SKLabelNode = SKLabelNode(fontNamed: "SpaceBarColors")
    var frtTextLabel: SKLabelNode = SKLabelNode(fontNamed: "emulogic")
    
    var textLabel: SKLabelNode = SKLabelNode(fontNamed: "HelveticaNeue")
    var textLabel2: SKLabelNode = SKLabelNode(fontNamed: "HelveticaNeue")
    
    fileprivate func startGame() {
        if let scene = GameScene( fileNamed:"GameScene"), let view = view {
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = false
            view.showsFields = false
            view.preferredFramesPerSecond = 60
            view.clearsContextBeforeDrawing = true
            view.isAsynchronous = true
            view.ignoresSiblingOrder = true
            view.clipsToBounds = true
            scene.scaleMode = .aspectFit
            scene.backgroundColor = SKColor.black
            view.presentScene(scene, transition: SKTransition.fade(withDuration: 3))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches as Set<UITouch>, with: event)
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if let name = touchedNode.name {
                
                func puckLeft() {
                    settings.puck = settings.puck > minpuck ? settings.puck - 1 : maxpuck
                }
                
                func puckRight() {
                    settings.puck = settings.puck < maxpuck ? settings.puck + 1 : minpuck
                }
                
                func puckCommon() {
                    if puckArray.indices.contains(settings.puck) {
                        puckLabel.text = puckArray[settings.puck]
                        puckTextLabel.text = puckTextArray[settings.puck]
                    }
                }
                
                //Animals
                if name == "puck-right" {
                    puckRight()
                    puckCommon()
                } else if name == "puck-left" {
                    puckLeft()
                    puckCommon()
                }
                
                func speaker() {
                    settings.sound.toggle()
                    let sfx = settings.sound ? 1 : 0
                    
                    if insArray.indices.contains(sfx) {
                        insLabel.text = insArray[sfx]
                        insTextLabel.text = insTextArray[sfx]
                    }
                }
                
                name == "ins-left" || name == "ins-right" ? speaker() : ()
                
                func levelLeft() {
                    settings.currentlevel = settings.currentlevel > 0 ? settings.currentlevel - 1 : settings.highlevel
                }
                
                func levelRight() {
                    settings.currentlevel = settings.currentlevel < settings.highlevel ? settings.currentlevel + 1 : 0
                }
                
                func levelCommon() {
                    if levelArray.indices.contains(settings.currentlevel) {
                        frtLabel.text = levelArray[settings.currentlevel]
                        frtTextLabel.text = "level \(settings.currentlevel + 1)"
                        frtLabel.zRotation = CGFloat(Int(rotation[settings.currentlevel % rotation.count]).degrees)
                    }
                }
                
                //Fruit / frt
                if name == "frt-left" {
                    levelLeft()
                    levelCommon()
                }
                
                if name == "frt-right" {
                    levelRight()
                    levelCommon()
                }
                
                if name == "enter" {
                   
                    let startAction = SKAction.run { [weak self] in
                        self?.startGame()
                    }
                    let fade1 = SKAction.fadeAlpha(to: 0.7, duration:TimeInterval(0.15))
                    let myDecay = SKAction.wait(forDuration: 0.15)
                    let myDecay2 = SKAction.wait(forDuration: 0.15 * 3)
                    let fade2 = SKAction.fadeAlpha(to: 1.0, duration:TimeInterval(0.15))
                    touchedNode.run(SKAction.sequence([fade1,myDecay,fade2]))
                    run(SKAction.sequence([myDecay2,startAction]))

                }
                
                /*
                 AudioServicesPlaySystemSound(1519) // Actuate `Peek` feedback (weak boom)
                 AudioServicesPlaySystemSound(1520) // Actuate `Pop` feedback (strong boom)
                 AudioServicesPlaySystemSound(1521) // Actuate `Nope` feedback (series of three weak booms)
                 */
                
            }
        }
    }
    
    override func didMove(to view: SKView) {
        scene?.speed = 1.0
        settings.level = 0
        
        if let pos = scene?.childNode(withName: "spacebar")?.position {
            let sprite = SKSpriteNode(imageNamed: "spacebarlogo")
            sprite.position = pos
            sprite.setScale(1.25)
            sprite.name = "enter"
            scene?.addChild(sprite)
            
            let label = SKLabelNode(fontNamed: "HelveticaNeue")
            label.fontColor = UIColor.white
            label.name = "copyright"
            label.fontSize = 30
            label.horizontalAlignmentMode = .center
            label.verticalAlignmentMode = .center
            label.position = pos
            label.position.y -= 90
            label.alpha = 0.5
            label.text = "© 2020-2021 Todd Bruss"
            scene?.addChild(label)
        }
        
        let highScoreText: SKLabelNode = SKLabelNode(fontNamed: "emulogic")
        let highScoreLabel: SKLabelNode = SKLabelNode(fontNamed: "emulogic")
        if let hiScorePos = scene?.childNode(withName: "highscore")?.position {
            highScoreLabel.position = hiScorePos
            highScoreLabel.position.y += 36
            highScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            highScoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            highScoreLabel.alpha = 1.0
            highScoreLabel.text = String("HI SCORE")
            highScoreLabel.fontSize = 30
            highScoreLabel.fontColor = UIColor.white
            scene?.addChild(highScoreLabel)
            
            highScoreText.position = hiScorePos
            highScoreText.position.y -= 36
            highScoreText.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            highScoreText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            highScoreText.alpha = 1.0
            highScoreText.text = String("\(settings.highscore)")
            highScoreText.fontSize = 30
            highScoreText.fontColor = UIColor.white
            scene?.addChild(highScoreText)
        }
        
        //animals Button
        //Left
        defineSprite (
            texture: "switchleft",
            scene: self,
            name: "puck-left",
            category: 0,
            collision: 0,
            contact: 0,
            field: 0,
            dynamic: false,
            allowRotation: false,
            affectedGravity: false,
            zPosition: 10,
            alpha: 0.75,
            speed: 0,
            alphaThreshold: 0,
            fontsize: Float(emojifontsize)
        ).drawHud(puckLabel: puckLabel, puckTextLabel: puckTextLabel, insLabel: insLabel, insTextLabel: insTextLabel, frtLabel: frtLabel, frtTextLabel: frtTextLabel, textLabel: textLabel, textLabel2: textLabel2)
        
        //animals Button
        //Right
        defineSprite (
            texture: "switchright",
            scene: self,
            name: "puck-right",
            category: 0,
            collision: 0,
            contact: 0,
            field: 0,
            dynamic: false,
            allowRotation: false,
            affectedGravity: false,
            zPosition: 10,
            alpha: 0.75,
            speed: 0,
            alphaThreshold: 0,
            fontsize: Float(emojifontsize)
        ).drawHud( puckLabel: puckLabel, puckTextLabel: puckTextLabel,  insLabel: insLabel, insTextLabel: insTextLabel, frtLabel: frtLabel, frtTextLabel: frtTextLabel, textLabel: textLabel, textLabel2: textLabel2   )
        
        defineSprite (
            texture: "switchleft",
            scene: self,
            name: "ins-left",
            category: 0,
            collision: 0,
            contact: 0,
            field: 0,
            dynamic: false,
            allowRotation: false,
            affectedGravity: false,
            zPosition: 10,
            alpha: 0.75,
            speed: 0,
            alphaThreshold: 0,
            fontsize: Float(emojifontsize)
        ).drawHud( puckLabel: puckLabel, puckTextLabel: puckTextLabel,  insLabel: insLabel, insTextLabel: insTextLabel, frtLabel: frtLabel, frtTextLabel: frtTextLabel, textLabel: textLabel, textLabel2: textLabel2   )
        
        //animals Button
        //Right
        defineSprite (
            texture: "switchright",
            scene: self,
            name: "ins-right",
            category: 0,
            collision: 0,
            contact: 0,
            field: 0,
            dynamic: false,
            allowRotation: false,
            affectedGravity: false,
            zPosition: 10,
            alpha: 0.75,
            speed: 0,
            alphaThreshold: 0,
            fontsize: Float(emojifontsize)
        ).drawHud( puckLabel: puckLabel, puckTextLabel: puckTextLabel,  insLabel: insLabel, insTextLabel: insTextLabel, frtLabel: frtLabel, frtTextLabel: frtTextLabel, textLabel: textLabel, textLabel2: textLabel2   )
        
        defineSprite (
            texture: "switchleft",
            scene: self,
            name: "frt-left",
            category: 0,
            collision: 0,
            contact: 0,
            field: 0,
            dynamic: false,
            allowRotation: false,
            affectedGravity: false,
            zPosition: 10,
            alpha: 0.75,
            speed: 0,
            alphaThreshold: 0,
            fontsize: Float(emojifontsize)
        ).drawHud( puckLabel: puckLabel, puckTextLabel: puckTextLabel,  insLabel: insLabel, insTextLabel: insTextLabel, frtLabel: frtLabel, frtTextLabel: frtTextLabel, textLabel: textLabel, textLabel2: textLabel2   )
        
        //animals Button
        //Right
        defineSprite (
            texture: "switchright",
            scene: self,
            name: "frt-right",
            category: 0,
            collision: 0,
            contact: 0,
            field: 0,
            dynamic: false,
            allowRotation: false,
            affectedGravity: false,
            zPosition: 10,
            alpha: 0.75,
            speed: 0,
            alphaThreshold: 0,
            fontsize: Float(emojifontsize)
        ).drawHud( puckLabel: puckLabel, puckTextLabel: puckTextLabel,  insLabel: insLabel, insTextLabel: insTextLabel, frtLabel: frtLabel, frtTextLabel: frtTextLabel, textLabel: textLabel, textLabel2: textLabel2)
    }
    
    struct defineSprite {
        let texture: String
        let scene: SKScene
        let name: String
        let category:UInt32
        let collision:UInt32
        let contact:UInt32
        let field:UInt32
        let dynamic:Bool
        let allowRotation:Bool
        let affectedGravity:Bool
        let zPosition:CGFloat
        let alpha:CGFloat
        let speed:CGFloat
        let alphaThreshold: Float
        let fontsize: Float
        
        func drawHud( puckLabel: SKLabelNode, puckTextLabel: SKLabelNode, insLabel: SKLabelNode, insTextLabel: SKLabelNode, frtLabel: SKLabelNode, frtTextLabel: SKLabelNode, textLabel: SKLabelNode, textLabel2: SKLabelNode )  {
            let sprite = SKSpriteNode(imageNamed: texture)
            let spc = CGFloat(220)
            let vspc = CGFloat(55)
            let vshift = CGFloat(20)
            
            if name == "puck-left", let pos = scene.childNode(withName: "pucks")?.position  {
                
                sprite.position = pos
                sprite.position.x = sprite.position.x - spc
                
                puckLabel.fontSize = CGFloat(fontsize)
                puckLabel.name = "puckLabel"
                puckLabel.horizontalAlignmentMode = .center
                puckLabel.verticalAlignmentMode = .center
                puckLabel.position = pos
                puckLabel.position.y = sprite.position.y + vspc - vshift
                scene.addChild(puckLabel)
                
                puckTextLabel.fontSize = CGFloat(30)
                puckTextLabel.fontColor = UIColor.white
                puckTextLabel.name = "puckTextLabel"
                puckTextLabel.horizontalAlignmentMode = .center
                puckTextLabel.verticalAlignmentMode = .center
                puckTextLabel.position = pos
                puckTextLabel.position.y = sprite.position.y - vspc - vshift
                
                scene.addChild(puckTextLabel)
            }
            
            if name == "puck-right", let pos = scene.childNode(withName: "pucks")?.position  {
                sprite.position = pos
                sprite.position.x = sprite.position.x + spc
            }
            
            if name == "ins-left", let pos = scene.childNode(withName: "ins")?.position  {
                
                sprite.position = pos
                sprite.position.x = sprite.position.x - spc
                
                insLabel.fontSize = CGFloat(fontsize)
                insLabel.name = "insLabel"
                insLabel.horizontalAlignmentMode = .center
                insLabel.verticalAlignmentMode = .center
                insLabel.position = pos
                insLabel.position.y = sprite.position.y + vspc - vshift
                scene.addChild(insLabel)
                
                insTextLabel.fontSize = CGFloat(30)
                insTextLabel.fontColor = UIColor.white
                insTextLabel.name = "insTextLabel"
                insTextLabel.horizontalAlignmentMode = .center
                insTextLabel.verticalAlignmentMode = .center
                insTextLabel.position = pos
                insTextLabel.position.y = sprite.position.y - vspc - vshift
                
                scene.addChild(insTextLabel)
            }
            
            if name == "ins-right", let pos = scene.childNode(withName: "ins")?.position {
                sprite.position = pos
                sprite.position.x = sprite.position.x + spc
            }
            
            
            if name == "frt-left", let pos = scene.childNode(withName: "fruit")?.position {
                
                sprite.position = pos
                sprite.position.x = sprite.position.x - spc
                
                frtLabel.fontSize = CGFloat(fontsize)
                frtLabel.name = "frtLabel"
                frtLabel.horizontalAlignmentMode = .center
                frtLabel.verticalAlignmentMode = .center
                frtLabel.position = pos
                frtLabel.position.y = sprite.position.y + vspc - vshift
                scene.addChild(frtLabel)
                
                frtTextLabel.fontSize = CGFloat(30)
                frtTextLabel.fontColor = UIColor.white
                frtTextLabel.name = "frtTextLabel"
                frtTextLabel.horizontalAlignmentMode = .center
                frtTextLabel.verticalAlignmentMode = .center
                frtTextLabel.position = pos
                frtTextLabel.position.y = sprite.position.y - vspc - vshift
                
                scene.addChild(frtTextLabel)
            }
            
            if name == "frt-right", let pos = scene.childNode(withName: "fruit")?.position {
                sprite.position = pos
                sprite.position.x = sprite.position.x + spc
            }
            
            sprite.alpha = alpha
            sprite.name = name
            
            scene.addChild(sprite)
            
            puckLabel.text = puckArray[settings.puck]
            puckTextLabel.text = puckTextArray[settings.puck]
            
            let soundfx = settings.sound ? 1 : 0
            insLabel.text = insArray[soundfx]
            insTextLabel.text = insTextArray[soundfx]
            
            settings.highlevel = settings.highlevel > levelArray.count - 1 ? levelArray.count - 1 : settings.highlevel
            settings.currentlevel = settings.currentlevel > levelArray.count - 1 ? levelArray.count - 1 : settings.currentlevel

            frtLabel.text = levelArray[settings.currentlevel]
            frtTextLabel.text = "level \(settings.currentlevel + 1)"
            frtLabel.zRotation = CGFloat(Int(rotation[settings.currentlevel % rotation.count]).degrees)
            
        }
    }
}

extension Int {
    var degrees: CGFloat {
        CGFloat(self) * .pi / 180.0
    }
}
