//
//  ParentalScene.swift
//  Fidget
//
//  Created by StarPlayr on 5/28/17.
//  Copyright © 2019 Todd Bruss. All rights reserved.
//

import SpriteKit
import AudioToolbox
import AVFoundation

/*
 🥋🎽🛹🛷⛸🥌
 🥍🏏🥅🏹🎣🥊
 🥏🎱🏓🏸🏒🏑
 🏀🏈🥎🎾🏐🏉
 😂🤣😊😇🙂🙃
 */


/*


 
 
 */
var puckArray: Array = [
    "😂","🤣","😊","😇","🙂","🙃",
    "🥋","🎽","🛹","🛷","⛸","🥌",
    "🥍","🏏","🥅","🏹","🎣","🥊",
    "🥏","🎱","🏓","🏸","🏒","🏑",
    "🏀","🏈","🥎","🎾","🏐","🏉",
]

var levelArray = ["😀","🥳","😂","🥴","😉","😕","😙","😬","😲","🤕","🤪","🤬","🤭","🥋","🥺","😨"]

var puckTextArray: Array = [
    "dual blue","dual red","dual orange","dual purple","dual green","dual magenta",
    "blue basket","red basket","orange basket","purple basket","green basket","magenta basket",
    "blue tennis","red tennis","orange tennis","pink tennis","green tennis","magenta tennis",
    "blue cross","red cross","orange cross","purple cross","green cross","magenta cross",
    "blue plus","red plus","orange plus","purple plus","green plus","magenta plus",
]

var insArray: Array = ["🔇","🔊"]
var insTextArray: Array = ["no sound fx","sound fx"]

var speakerBool = true

var puck = 0
var level = 0

var ins = 0
var frt = 1
var food = 1

var insSet = 1
var frtSet = 1
var foodSet = 1

class ParentalScene: SKScene, AVSpeechSynthesizerDelegate {
    
    var maxpuck = puckArray.count - 1
    var minpuck = 0
    
    var maxins = insArray.count - 1
    var minins = 0
    
    var maxlevel = levelArray.count - 1
    var minlevel = 0
    
    var emojifontsize = CGFloat(150)
    var puckLabel: SKLabelNode = SKLabelNode(fontNamed: "SpaceBarColors")
    var puckTextLabel: SKLabelNode = SKLabelNode(fontNamed: "HelveticaNeue")
    
    var insLabel: SKLabelNode = SKLabelNode(fontNamed: "SpaceBarColors")
    var insTextLabel: SKLabelNode = SKLabelNode(fontNamed: "HelveticaNeue")
    
    var frtLabel: SKLabelNode = SKLabelNode(fontNamed: "SpaceBarColors")
    var frtTextLabel: SKLabelNode = SKLabelNode(fontNamed: "HelveticaNeue")
    
    var textLabel: SKLabelNode = SKLabelNode(fontNamed: "HelveticaNeue")
    var textLabel2: SKLabelNode = SKLabelNode(fontNamed: "HelveticaNeue")
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches as Set<UITouch>, with: event)
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if let name = touchedNode.name {
                //print(touchedNode as Any)
                
                func puckLeft() {
                    puck = puck > minpuck ? puck - 1 : maxpuck
                }
                
                func puckRight() {
                    puck = puck < maxpuck ? puck + 1 : minpuck
                }
                
                func puckCommon() {
                    if puckArray.indices.contains(puck) {
                        puckLabel.text = puckArray[puck]
                        puckTextLabel.text = puckTextArray[puck]
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
                    speakerBool.toggle()
                    ins = speakerBool ? 1 : 0
                    
                    if insArray.indices.contains(ins) {
                        insLabel.text = insArray[ins]
                        insTextLabel.text = insTextArray[ins]
                    }
                    
                    settings.sound = speakerBool
                    
                    print("settings.sound",settings.sound)
                }
                
                (name == "ins-left" || name == "ins-right") ? speaker() : ()
                
                func levelLeft() {
                    level = level > minlevel ? level - 1 : maxlevel
                }
                
                func levelRight() {
                    level = level < maxlevel ? level + 1 : minlevel
                }
                
                func levelCommon() {
                    if levelArray.indices.contains(level) {
                        frtLabel.text = levelArray[level]
                        frtTextLabel.text = "level \(level + 1)"
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
                
                /*if name == "speaker" {
                 
                 let speakText = "Kids, Ask your parents to match the words with e-moe-gees. After completing the puzzle, press Enter."
                 
                 let utterance = AVSpeechUtterance(string:speakText)
                 utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                 let voice = AVSpeechSynthesizer()
                 voice.speak(utterance)
                 }*/
                
                if name == "enter" {
                    
                    let runcode = SKAction.run {
                        
                        if let scene = GameScene( fileNamed:"GameScene" ) {
                            
                            scene.run(forever)
                            
                            // Configure the view.
                            let skView = self.view! as SKView
                            skView.showsFPS = false
                            skView.showsNodeCount = false
                            skView.showsPhysics = false
                            skView.showsFields = false
                            skView.preferredFramesPerSecond = 60
                            skView.clearsContextBeforeDrawing = true
                            skView.isAsynchronous = true
                            
                            /* Sprite Kit applies additional optimizations to improve rendering performance */
                            skView.ignoresSiblingOrder = true
                            
                            skView.clipsToBounds = true
                            /* Set the scale mode to scale to fit the window */
                            scene.scaleMode = .aspectFit
                            scene.backgroundColor = SKColor.black
                            skView.presentScene(scene, transition: SKTransition.fade(withDuration: 2))
                        }
                    }
                    
                    let fade1 = SKAction.fadeAlpha(to: 0.7, duration:TimeInterval(0.15))
                    let myDecay = SKAction.wait(forDuration: 0.15)
                    let fade2 = SKAction.fadeAlpha(to: 1.0, duration:TimeInterval(0.15))
                    touchedNode.run(SKAction.sequence([fade1,myDecay,fade2,runcode]))
                    
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
        ).drawHud( puckLabel: puckLabel, puckTextLabel: puckTextLabel,  insLabel: insLabel, insTextLabel: insTextLabel,  frtLabel: frtLabel, frtTextLabel: frtTextLabel, textLabel: textLabel, textLabel2: textLabel2   )
        
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
        ).drawHud( puckLabel: puckLabel, puckTextLabel: puckTextLabel,  insLabel: insLabel, insTextLabel: insTextLabel,  frtLabel: frtLabel, frtTextLabel: frtTextLabel, textLabel: textLabel, textLabel2: textLabel2   )
        
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
        ).drawHud( puckLabel: puckLabel, puckTextLabel: puckTextLabel,  insLabel: insLabel, insTextLabel: insTextLabel,  frtLabel: frtLabel, frtTextLabel: frtTextLabel, textLabel: textLabel, textLabel2: textLabel2   )
        
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
        ).drawHud( puckLabel: puckLabel, puckTextLabel: puckTextLabel,  insLabel: insLabel, insTextLabel: insTextLabel,  frtLabel: frtLabel, frtTextLabel: frtTextLabel, textLabel: textLabel, textLabel2: textLabel2   )
    
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
        ).drawHud( puckLabel: puckLabel, puckTextLabel: puckTextLabel,  insLabel: insLabel, insTextLabel: insTextLabel,  frtLabel: frtLabel, frtTextLabel: frtTextLabel, textLabel: textLabel, textLabel2: textLabel2   )
        
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
        ).drawHud( puckLabel: puckLabel, puckTextLabel: puckTextLabel,  insLabel: insLabel, insTextLabel: insTextLabel,  frtLabel: frtLabel, frtTextLabel: frtTextLabel, textLabel: textLabel, textLabel2: textLabel2)
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
            //let lalpha = CGFloat(0.75)
            
            if name == "puck-left" {
                
                sprite.position =  (scene.childNode(withName: "pucks")?.position)!
                sprite.position.x = sprite.position.x - spc
                
                puckLabel.fontSize = CGFloat(fontsize)
                puckLabel.name = "puckLabel"
                puckLabel.horizontalAlignmentMode = .center
                puckLabel.verticalAlignmentMode = .center
                puckLabel.position = (scene.childNode(withName: "pucks")?.position)!
                puckLabel.position.y = sprite.position.y + vspc - vshift
                scene.addChild(puckLabel)
                
                puckTextLabel.fontSize = CGFloat(37)
                puckTextLabel.fontColor = UIColor.white
                puckTextLabel.name = "puckTextLabel"
                puckTextLabel.horizontalAlignmentMode = .center
                puckTextLabel.verticalAlignmentMode = .center
                puckTextLabel.position = (scene.childNode(withName: "pucks")?.position)!
                puckTextLabel.position.y = sprite.position.y - vspc - vshift
                
                scene.addChild(puckTextLabel)
            }
            
            if name == "puck-right" {
                
                sprite.position =  (scene.childNode(withName: "pucks")?.position)!
                sprite.position.x = sprite.position.x + spc
            }
            
            if name == "ins-left" {
                
                sprite.position =  (scene.childNode(withName: "ins")?.position)!
                sprite.position.x = sprite.position.x - spc
                
                insLabel.fontSize = CGFloat(fontsize)
                insLabel.name = "insLabel"
                insLabel.horizontalAlignmentMode = .center
                insLabel.verticalAlignmentMode = .center
                insLabel.position = (scene.childNode(withName: "ins")?.position)!
                insLabel.position.y = sprite.position.y + vspc - vshift
                scene.addChild(insLabel)
                
                insTextLabel.fontSize = CGFloat(37)
                insTextLabel.fontColor = UIColor.white
                insTextLabel.name = "insTextLabel"
                insTextLabel.horizontalAlignmentMode = .center
                insTextLabel.verticalAlignmentMode = .center
                insTextLabel.position = (scene.childNode(withName: "ins")?.position)!
                insTextLabel.position.y = sprite.position.y - vspc - vshift
                
                scene.addChild(insTextLabel)
            }
            
            if name == "ins-right" {
                
                sprite.position =  (scene.childNode(withName: "ins")?.position)!
                sprite.position.x = sprite.position.x + spc
            }
            
            
            if name == "frt-left" {
                
                sprite.position =  (scene.childNode(withName: "fruit")?.position)!
                sprite.position.x = sprite.position.x - spc
                
                frtLabel.fontSize = CGFloat(fontsize)
                frtLabel.name = "frtLabel"
                frtLabel.horizontalAlignmentMode = .center
                frtLabel.verticalAlignmentMode = .center
                frtLabel.position = (scene.childNode(withName: "fruit")?.position)!
                frtLabel.position.y = sprite.position.y + vspc - vshift
                scene.addChild(frtLabel)
                
                frtTextLabel.fontSize = CGFloat(37)
                frtTextLabel.fontColor = UIColor.white
                frtTextLabel.name = "frtTextLabel"
                frtTextLabel.horizontalAlignmentMode = .center
                frtTextLabel.verticalAlignmentMode = .center
                frtTextLabel.position = (scene.childNode(withName: "fruit")?.position)!
                frtTextLabel.position.y = sprite.position.y - vspc - vshift
                
                scene.addChild(frtTextLabel)
            }
            
            if name == "frt-right" {
                sprite.position = (scene.childNode(withName: "fruit")?.position)!
                sprite.position.x = sprite.position.x + spc
            }
            
            sprite.alpha = alpha
            sprite.name = name
            
            scene.addChild(sprite)
            
            puckLabel.text = puckArray[puck]
            puckTextLabel.text = puckTextArray[puck]
 
            insLabel.text = insArray[1]
            insTextLabel.text = insTextArray[1]
            
            frtLabel.text = levelArray[0]
            frtTextLabel.text = "level 1"
        }
    }
}
