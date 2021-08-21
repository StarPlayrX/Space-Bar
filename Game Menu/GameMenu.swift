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

var puckArray: Array = [
    "😂",
    "😂","🤣","😊","😇","🙂","🙃",
    "🥋","🎽","🛹","🛷","⛸","🥌",
    "🥍","🏏","🥅","🏹","🎣","🥊",
    "🥏","🎱","🏓","🏸","🏒","🏑",
    "🏀","🏈","🥎","🎾","🏐","🏉",
    "🥊"
]

var puckTextArray: Array = [
    "dual blue",
    "dual blue","dual red","dual orange","dual purple","dual green","dual magenta",
    "blue basket","red basket","orange basket","purple basket","green basket","magenta basket",
    "blue tennis","red tennis","orange tennis","pink tennis","green tennis","magenta tennis",
    "blue cross","red cross","orange cross","purple cross","green cross","magenta cross",
    "blue plus","red plus","orange plus","purple plus","green plus","magenta plus",
    "magenta crosshairs"
]

var insArray: Array = ["🐝","🐝","🐛","🦋","🐞","🦎","🐙","🐟","🐬","🐬"]
var insTextArray: Array = ["bee","bee","caterpillar","butterfly","lady bug","gecko","squid","fish","dolphin","dolphin"]

var frtArray: Array = ["🍎","🍎","🍐","🍊","🍋","🍉","🥝","🥑","🍅","🍅"]
var frtTextArray: Array = ["apple","apple","pear","tangerine","lemon","watermelon","kiwi","avocado", "tomato","tomato"]


var puck = 1
var ins = 1
var frt = 1
var food = 1

var puckSet = 1
var insSet = 1
var frtSet = 1
var foodSet = 1

class ParentalScene: SKScene, AVSpeechSynthesizerDelegate {
    
    var maxpuck = puckArray.count - 2
    var minpuck = 1
    
    var maxins = 8
    var minins = 1
    
    var maxfrt = 8
    var minfrt = 1
    
    var emojifontsize = CGFloat(150)
    var puckLabel: SKLabelNode = SKLabelNode(fontNamed: "SpaceBarColors")
    var puckTextLabel: SKLabelNode = SKLabelNode(fontNamed: "HelveticaNeue")
    
    var insLabel: SKLabelNode = SKLabelNode(fontNamed: "Apple Color Emoji")
    var insTextLabel: SKLabelNode = SKLabelNode(fontNamed: "HelveticaNeue")
    
    var frtLabel: SKLabelNode = SKLabelNode(fontNamed: "Apple Color Emoji")
    var frtTextLabel: SKLabelNode = SKLabelNode(fontNamed: "HelveticaNeue")
    
    var textLabel: SKLabelNode = SKLabelNode(fontNamed: "HelveticaNeue")
    var textLabel2: SKLabelNode = SKLabelNode(fontNamed: "HelveticaNeue")
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches as Set<UITouch>, with: event)
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if let name = touchedNode.name {
                
                func puckRight() {
                    puck >= minpuck ? (puck -= 1) : (puck = maxpuck)
                }
                
                func puckLeft() {
                    puck <= maxpuck ? (puck += 1) : (puck = minpuck)
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
                
                //Insects / ins
                if name == "ins-left" {
                    if ins >= minins {
                        ins = ins - 1
                    }
                    
                    if ins >= minins  {
                        insLabel.text = insArray[ ins ]
                    } else {
                        ins = maxins
                        insLabel.text = insArray[ ins ]
                    }
                }
                
                
                if name == "ins-right" {
                    if ins <= maxins {
                        ins = ins + 1
                    }
                    
                    if ins  <= maxins  {
                        insLabel.text = insArray[ ins ]
                    } else {
                        ins  = minins
                        insLabel.text = insArray[ ins ]
                    }
                }
                
                //Fruit / frt
                if name == "frt-left" {
                    if frt >= minfrt {
                        frt = frt - 1
                    }
                    
                    if frt >= minfrt  {
                        frtLabel.text = frtArray[ frt ]
                    } else {
                        frt = maxfrt
                        frtLabel.text = frtArray[ frt ]
                    }
                }
                
                
                if name == "frt-right" {
                    if frt <= maxfrt {
                        frt = frt + 1
                    }
                    
                    if frt  <= maxfrt  {
                        frtLabel.text = frtArray[ frt ]
                    } else {
                        frt  = minfrt
                        frtLabel.text = frtArray[ frt ]
                    }
                }
                
                
                if name == "speaker" {
                    
                    let speakText = "Kids, Ask your parents to match the words with e-moe-gees. After completing the puzzle, press Enter."
                    
                    let utterance = AVSpeechUtterance(string:speakText)
                    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                    let voice = AVSpeechSynthesizer()
                    voice.speak(utterance)
                }
                
            
                if name == "enter" {
            
                    var shouldContinue = false
                    
                    //If we have a match
                    if 1 == 1 {
                        shouldContinue = true
                    }
                    
                    if shouldContinue {
                        
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
                        
                    } else {
                        
                        let runcode = SKAction.run {
                            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                        }
                        
                        let fade1 = SKAction.fadeAlpha(to: 0.7, duration:TimeInterval(0.15))
                        let myDecay = SKAction.wait(forDuration: 0.15)
                        let fade2 = SKAction.fadeAlpha(to: 1.0, duration:TimeInterval(0.15))
                        touchedNode.run(SKAction.sequence([fade1,myDecay,fade2,runcode]))
                    
                    }
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
            ).drawHud( puckLabel: puckLabel, puckTextLabel: puckTextLabel,  insLabel: insLabel, insTextLabel: insTextLabel,  frtLabel: frtLabel, frtTextLabel: frtTextLabel, textLabel: textLabel, textLabel2: textLabel2   )
        
        
        //animals Button
        //Right
        defineSprite (
            texture: "speaker",
            scene: self,
            name: "speaker",
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
            ).drawHud( puckLabel: puckLabel, puckTextLabel: puckTextLabel,  insLabel: insLabel, insTextLabel: insTextLabel,  frtLabel: frtLabel, frtTextLabel: frtTextLabel, textLabel: textLabel, textLabel2: textLabel2  )
        
        
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
                
                sprite.position =  (scene.childNode(withName: "fruit")?.position)!
                sprite.position.x = sprite.position.x + spc
            }
            
            
            
            
            if name == "speaker" {
                
                sprite.position =  (scene.childNode(withName: "speaker")?.position)!
                
                textLabel.fontSize = CGFloat(37)
                textLabel.fontColor = UIColor.white
                textLabel.name = "speaker"
                textLabel.horizontalAlignmentMode = .left
                textLabel.verticalAlignmentMode = .center
                textLabel.position = (scene.childNode(withName: "text")?.position)!
                //textLabel.position.y = sprite.position.y + vspc - vshift

                textLabel.text = "Kids, ask your parents to"
                scene.addChild(textLabel)
                
                textLabel2.fontSize = CGFloat(37)
                textLabel2.fontColor = UIColor.white
                textLabel2.name = "speaker"
                textLabel2.horizontalAlignmentMode = .left
                textLabel2.verticalAlignmentMode = .center
                textLabel2.position = (scene.childNode(withName: "text2")?.position)!
                textLabel2.text = "match the words with emojis."
                scene.addChild(textLabel2)
            }
            
            puckSet = 1
            
           /* while animalsSet == animals2 {
                animalsSet = Int(arc4random_uniform(8) + 1)
                animals2 = Int(arc4random_uniform(8) + 1)
                puck = animals2
            }*/
            
            
            insSet = 0
            var ins2 = 0
            
            while insSet == ins2 {
                insSet = Int(arc4random_uniform(8) + 1)
                ins2 = Int(arc4random_uniform(8) + 1)
                ins = ins2
            }
      
            
            frtSet = 0
            var frt2 = 0
            
            while frtSet == frt2 {
                frtSet = Int(arc4random_uniform(8) + 1)
                frt2 = Int(arc4random_uniform(8) + 1)
                frt = frt2
            }
         
        
            //sprite.zPosition = 200
            sprite.alpha = alpha
            sprite.name = name
            
            scene.addChild(sprite)
            
            puckLabel.text = puckArray[puck]
            puckTextLabel.text = puckTextArray[puckSet]
            insLabel.text = insArray[ins2]
            insTextLabel.text = insTextArray[insSet]
            
            frtLabel.text = frtArray[frt2]
            frtTextLabel.text = frtTextArray[frtSet]
            
        }
    }
}
