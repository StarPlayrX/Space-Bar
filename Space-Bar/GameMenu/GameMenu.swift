//
//  GameScene.swift
//  Space-Bar
//
//  Created by Todd Bruss on 10/5/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import SpriteKit
//import GameplayKit

class GameMenu: SKScene {
    override func sceneDidLoad() {        
        g.showCursor = true
        g.runningGame = false
        
    #if targetEnvironment(macCatalyst)
        NSCursor.unhide()
    #endif
    }
    
    var keyPressed = false
    
    deinit {
        removeAllActions()
        removeAllChildren()
        removeFromParent()
    }
    
    var puckLabel: SKLabelNode = SKLabelNode(fontNamed: "SpaceBarColors")
    var puckTextLabel: SKLabelNode = SKLabelNode(fontNamed: "emulogic")
    
    var soundfxLabel: SKLabelNode = SKLabelNode(fontNamed: "SpaceBarColors")
    var soundfxTextLabel: SKLabelNode = SKLabelNode(fontNamed: "emulogic")
    
    var lvlLabel: SKLabelNode = SKLabelNode(fontNamed: "SpaceBarColors")
    var lvlTextLabel: SKLabelNode = SKLabelNode(fontNamed: "emulogic")
    
    var textLabel: SKLabelNode = SKLabelNode(fontNamed: "CourierNeue")
    var textLabel2: SKLabelNode = SKLabelNode(fontNamed: "CourierNeue")
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches as Set<UITouch>, with: event)
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if let name = touchedNode.name {
                
                func puckLeft() {
                    settings.puck = settings.puck > 0 ? settings.puck - 1 : Global.shared.gameBall.count - 1
                }
                
                func puckRight() {
                    settings.puck = settings.puck < Global.shared.gameBall.count - 1 ? settings.puck + 1 : 0
                }
                
                func puckCommon() {
                    let ball = Global.shared.gameBall
                    let text = Global.shared.gameBallText
                    
                    if ball.indices.contains(settings.puck) {
                        puckLabel.text = ball[settings.puck]
                        puckTextLabel.text = text[settings.puck]
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
                    
                    if Global.shared.soundFx.indices.contains(sfx) {
                        soundfxLabel.text = Global.shared.soundFx[sfx]
                        soundfxTextLabel.text = Global.shared.soundFxText[sfx]
                    }
                }
                
                name == "soundfx-left" || name == "soundfx-right" ? speaker() : ()
                
                func levelLeft() {
                    settings.currentlevel = settings.currentlevel > 0 ? settings.currentlevel - 1 : settings.highlevel
                }
                
                func levelRight() {
                    settings.currentlevel = settings.currentlevel < settings.highlevel ? settings.currentlevel + 1 : 0
                }
                
                func levelCommon() {
                    let rotation = Global.shared.rotation
                    let levels = Global.shared.levels
                    if levels.indices.contains(settings.currentlevel) {
                        lvlLabel.text = levels[settings.currentlevel]
                        lvlTextLabel.text = "level \(settings.currentlevel + 1)"
                        lvlLabel.zRotation = CGFloat(Int(rotation[settings.currentlevel % rotation.count]).degrees)
                    }
                }
                
                //MARK: - Levels
                if name == "lvl-left" {
                    levelLeft()
                    levelCommon()
                }
                
                if name == "lvl-right" {
                    levelRight()
                    levelCommon()
                }
                
                if name == "enter" && !keyPressed {
                    if keyPressed { return }
                    keyPressed = true
                    settings.startlevel = settings.currentlevel

                    let runcode = SKAction.run { [self] in
                        if let scene = SKScene(fileNamed: "GameScene") {
                            gScene = scene
                            
                            //sceneNode.entities = scene.entities
                            //sceneNode.graphs = scene.graphs
                            scene.scaleMode = .aspectFit
                            
                            // Present the scene
                            if let view = self.view as SKView? {
                                scene.speed = 1.0
                                view.showsFPS = false
                                view.showsNodeCount = false
                                view.showsPhysics = false
                                view.showsFields = false
                                view.clearsContextBeforeDrawing = true
                                view.isAsynchronous = true
                                view.ignoresSiblingOrder = true
                                view.clipsToBounds = true
                                view.backgroundColor = SKColor.black
                                view.isMultipleTouchEnabled = false
                                view.presentScene(scene)
                            }
                        }
                    }
                    
                    let fade1 = SKAction.fadeAlpha(to: 0.7, duration:TimeInterval(0.15))
                    let myDecay = SKAction.wait(forDuration: 0.15)
                    let fade2 = SKAction.fadeAlpha(to: 1.0, duration:TimeInterval(0.15))
                    touchedNode.run(SKAction.sequence([fade1,myDecay,fade2,runcode]))
                }
                
                if name == "leader" && !keyPressed {
                    if keyPressed { return }
                    keyPressed = true
                    
                    let runcode = SKAction.run { [self] in
                        if let scene = SKScene(fileNamed: "GameLeader") {
                            //gScene = scene
                            
                            //sceneNode.entities = scene.entities
                            //sceneNode.graphs = scene.graphs
                            scene.scaleMode = .aspectFit
                            
                            // Present the scene
                            if let view = self.view as SKView? {
                                scene.speed = 1.0
                                view.showsFPS = false
                                view.showsNodeCount = false
                                view.showsPhysics = false
                                view.showsFields = false
                                view.clearsContextBeforeDrawing = true
                                view.isAsynchronous = true
                                view.ignoresSiblingOrder = true
                                view.clipsToBounds = true
                                view.backgroundColor = SKColor.black
                                view.isMultipleTouchEnabled = false
                                view.presentScene(scene)
                            }
                        }
                    }
                    
                    let fade1 = SKAction.fadeAlpha(to: 0.7, duration:TimeInterval(0.15))
                    let myDecay = SKAction.wait(forDuration: 0.15)
                    let fade2 = SKAction.fadeAlpha(to: 1.0, duration:TimeInterval(0.15))
                    touchedNode.run(SKAction.sequence([fade1,myDecay,fade2,runcode]))
                }
            }
        }
    }
    
    override func didMove(to view: SKView) {
        
        g.showCursor = true
        
    #if targetEnvironment(macCatalyst)
        NSCursor.unhide()
    #endif
        
        settings.level = 0
        scene?.alpha = 0.0
        
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
            label.text = "© 2022 by Todd Bruss, all rights reserved"
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
            fontsize: Float(150)
        ).drawHud( puckLabel: puckLabel, puckTextLabel: puckTextLabel, soundfxLabel: soundfxLabel, soundfxTextLabel: soundfxTextLabel, lvlLabel: lvlLabel, lvlTextLabel: lvlTextLabel)
        
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
            fontsize: Float(150)
        ).drawHud( puckLabel: puckLabel, puckTextLabel: puckTextLabel, soundfxLabel: soundfxLabel, soundfxTextLabel: soundfxTextLabel, lvlLabel: lvlLabel, lvlTextLabel: lvlTextLabel)
        
        defineSprite (
            texture: "switchleft",
            scene: self,
            name: "soundfx-left",
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
            fontsize: Float(150)
        ).drawHud( puckLabel: puckLabel, puckTextLabel: puckTextLabel, soundfxLabel: soundfxLabel, soundfxTextLabel: soundfxTextLabel, lvlLabel: lvlLabel, lvlTextLabel: lvlTextLabel)
        
        //Right
        defineSprite (
            texture: "switchright",
            scene: self,
            name: "soundfx-right",
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
            fontsize: Float(150)
        ).drawHud( puckLabel: puckLabel, puckTextLabel: puckTextLabel, soundfxLabel: soundfxLabel, soundfxTextLabel: soundfxTextLabel, lvlLabel: lvlLabel, lvlTextLabel: lvlTextLabel)
        
        defineSprite (
            texture: "switchleft",
            scene: self,
            name: "lvl-left",
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
            fontsize: Float(150)
        ).drawHud( puckLabel: puckLabel, puckTextLabel: puckTextLabel, soundfxLabel: soundfxLabel, soundfxTextLabel: soundfxTextLabel, lvlLabel: lvlLabel, lvlTextLabel: lvlTextLabel)
        
        //Right
        defineSprite (
            texture: "switchright",
            scene: self,
            name: "lvl-right",
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
            fontsize: Float(150)
        ).drawHud( puckLabel: puckLabel, puckTextLabel: puckTextLabel, soundfxLabel: soundfxLabel, soundfxTextLabel: soundfxTextLabel, lvlLabel: lvlLabel, lvlTextLabel: lvlTextLabel)
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
        
        func drawHud(
            puckLabel: SKLabelNode,
            puckTextLabel: SKLabelNode,
            soundfxLabel: SKLabelNode,
            soundfxTextLabel: SKLabelNode,
            lvlLabel: SKLabelNode,
            lvlTextLabel: SKLabelNode)
        {
            let rotation = Global.shared.rotation
            let levels   = Global.shared.levels
            
            let sprite = SKSpriteNode(imageNamed: texture)
            let spc = CGFloat(220)
            let vspc = CGFloat(55)
            let vshift = CGFloat(20)
            
            if name == "puck-left", let pos = scene.childNode(withName: "pucks")?.position {
                
                sprite.position = pos
                sprite.position.x -= spc
                
                puckLabel.fontSize = CGFloat(fontsize)
                puckLabel.name = "puckLabel"
                puckLabel.horizontalAlignmentMode = .center
                puckLabel.verticalAlignmentMode = .center
                puckLabel.position = pos
                puckLabel.position.y += vspc - vshift
                scene.addChild(puckLabel)
                
                puckTextLabel.fontSize = CGFloat(30)
                puckTextLabel.fontColor = UIColor.white
                puckTextLabel.name = "puckTextLabel"
                puckTextLabel.horizontalAlignmentMode = .center
                puckTextLabel.verticalAlignmentMode = .center
                puckTextLabel.position = pos
                puckTextLabel.position.y += -vspc - vshift
                
                scene.addChild(puckTextLabel)
            }
            
            if name == "puck-right", let pos = scene.childNode(withName: "pucks")?.position {
                sprite.position = pos
                sprite.position.x += spc
            }
            
            if name == "soundfx-left", let pos = scene.childNode(withName: "soundfx")?.position  {
                
                sprite.position = pos
                sprite.position.x -= spc
                
                soundfxLabel.fontSize = CGFloat(fontsize)
                soundfxLabel.name = "soundfxLabel"
                soundfxLabel.horizontalAlignmentMode = .center
                soundfxLabel.verticalAlignmentMode = .center
                soundfxLabel.position = pos
                soundfxLabel.position.y += vspc - vshift
                scene.addChild(soundfxLabel)
                
                soundfxTextLabel.fontSize = CGFloat(30)
                soundfxTextLabel.fontColor = UIColor.white
                soundfxTextLabel.name = "soundfxTextLabel"
                soundfxTextLabel.horizontalAlignmentMode = .center
                soundfxTextLabel.verticalAlignmentMode = .center
                soundfxTextLabel.position = pos
                soundfxTextLabel.position.y += -vspc - vshift
                
                scene.addChild(soundfxTextLabel)
            }
            
            if name == "soundfx-right", let pos = scene.childNode(withName: "soundfx")?.position {
                sprite.position = pos
                sprite.position.x += spc
            }
            
            if name == "lvl-left", let pos = scene.childNode(withName: "level")?.position {
                sprite.position = pos
                sprite.position.x -= spc
                
                lvlLabel.fontSize = CGFloat(fontsize)
                lvlLabel.name = "lvlLabel"
                lvlLabel.horizontalAlignmentMode = .center
                lvlLabel.verticalAlignmentMode = .center
                lvlLabel.position = pos
                lvlLabel.position.y += vspc - vshift
                scene.addChild(lvlLabel)
                
                lvlTextLabel.fontSize = CGFloat(30)
                lvlTextLabel.fontColor = UIColor.white
                lvlTextLabel.name = "lvlTextLabel"
                lvlTextLabel.horizontalAlignmentMode = .center
                lvlTextLabel.verticalAlignmentMode = .center
                lvlTextLabel.position = pos
                lvlTextLabel.position.y += -vspc - vshift
                scene.addChild(lvlTextLabel)
            }
            
            if name == "lvl-right", let pos = scene.childNode(withName: "level")?.position {
                sprite.position = pos
                sprite.position.x += spc
            }
            
            sprite.alpha = alpha
            sprite.name = name
            
            scene.addChild(sprite)
            
            puckLabel.text = Global.shared.gameBall[settings.puck]
            puckTextLabel.text = Global.shared.gameBallText[settings.puck]
            
            let soundfx = settings.sound ? 1 : 0
            soundfxLabel.text = Global.shared.soundFx[soundfx]
            soundfxTextLabel.text = Global.shared.soundFxText[soundfx]
            
            settings.highlevel = settings.highlevel > levels.count - 1 ? levels.count - 1 : settings.highlevel
            settings.currentlevel = settings.currentlevel > levels.count - 1 ? levels.count - 1 : settings.currentlevel
            
            lvlLabel.text = levels[settings.currentlevel]
            lvlTextLabel.text = "level \(settings.currentlevel + 1)"
            lvlLabel.zRotation = CGFloat(Int(rotation[settings.currentlevel % rotation.count]).degrees)
            
            let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.0)
            scene.run(fadein)
        }
    }
}

extension Int {
    var degrees: CGFloat {
        CGFloat(self) * .pi / 180.0
    }
}
