//
//  GameScene.swift
//  Space Bar
//
//  Created by Todd Bruss on 2/5/18.
//  Copyright © 2018 Todd Bruss. All rights reserved.
//

import SpriteKit
import AVFoundation

//import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate, AVAudioPlayerDelegate {
    // Our Game's Actors
    let paddleNode = SKSpriteNode() //available to the entire class
    let ballNode = SKSpriteNode() //da ball
    let goalNode = SKSpriteNode() //da ball
    
    //Music Player
    var audioPlayer = AVAudioPlayer()
    
    //Categories
    let paddleCategory = UInt32(1)
    let ballCategory = UInt32(2)
    let brickCategory = UInt32(4)
    let unusedCategory = UInt32(8)
    let wallCategory = UInt32(16)
    let goalCategory = UInt32(32)
    let midCategory = UInt32(64)
    let vortexCategory = UInt32(128)
    let lowerLeftCornerCategory = UInt32(256)
    let lowerRightCornerCategory = UInt32(512)
    let upperLeftCornerCategory = UInt32(1024)
    let upperRightCornerCategory = UInt32(2048)
    
    var bricksTileMap = SKTileMapNode()
    var space = SKReferenceNode()
    
    //Positioning variables
    var anchor = CGPoint()
    var anchorNode = SKNode()
    var width = CGFloat()
    var height = CGFloat()
    var centerWidth = CGFloat()
    var centerHeight = CGFloat()

    //Initial Variables
    var brickCounter = Int(0)
    var gameLevel = Int(settings.level)
    var gameScore = Int(0)
    var gameLives = Int(settings.lives)
    let scoreLabel = SKLabelNode(fontNamed:"emulogic")
    let levelLabel = SKLabelNode(fontNamed:"emulogic")
    let livesLabel = SKLabelNode(fontNamed:"emulogic")
    
    let goalSound = SKAction.playSoundFileNamed("Dah.m4a", waitForCompletion: false)
    let brickSound = SKAction.playSoundFileNamed("Bip.m4a", waitForCompletion: false)
    let paddleSound = SKAction.playSoundFileNamed("Knock.m4a", waitForCompletion: false)
    let wallSound = SKAction.playSoundFileNamed("Dat.m4a", waitForCompletion: false)
    
    let backParalax = SKNode() //Center Node
    
    //corners
    let corneredge = CGFloat(32)
    let cornertopedge = CGFloat(86)
    
    //labels
    let labelspace = CGFloat(28)
    let labeledges = CGFloat(65)
    
    //paddleHeight
    var paddleHeight = CGFloat(4)
    
    //ipad Level
    var ipadString = ""
    
    func drawLevel() {
        
        //let playLevel = gameLevel % 5
        //print("playLevel:", playLevel)
            
        let str = String(gameLevel % 15)
     
        let filename = "level" + str + String(ipadString)
        // + String(playLevel)
        
        for center in self.children {
            if (center.name == "Center") {
                //Check if level exists first (safe)
                if let _ = GameScene(fileNamed: filename ) {
                    space = SKReferenceNode(fileNamed: filename)
                    space.name = "Space"
                    
                    //This becomes our pseudo anchor point
                    center.position = CGPoint(x: centerWidth, y: centerHeight)
                    
                    space.position = CGPoint(x: 0, y: centerHeight - 240)
                    
                    
                    bricksTileMap = space.childNode(withName: "//bricks") as! SKTileMapNode //as! SKTileMapNode
                    center.addChild(space)
                }
            }
        }
    }
    
    func drawParallax() {
        anchorNode.addChild(backParalax)
        backParalax.position = CGPoint(x: CGFloat(centerWidth), y: CGFloat(centerHeight))
        
        let starryNightTexture = SKTexture(imageNamed: "starfield1")
        
        let moveGroundSprite = SKAction.moveBy(x: 0, y: -starryNightTexture.size().height, duration: TimeInterval(0.012 * starryNightTexture.size().height))
        let resetGroundSprite = SKAction.moveBy(x: 0, y: starryNightTexture.size().height, duration: 0.0)
        let moveGroundSpritesForever = SKAction.repeatForever(SKAction.sequence([moveGroundSprite,resetGroundSprite]))
        
        for i in -2..<Int(self.frame.size.height / ( starryNightTexture.size().height)) + 2 {
            let sprite = SKSpriteNode(texture: starryNightTexture)
            sprite.position = CGPoint(x: -centerWidth, y: CGFloat(i) * (sprite.size.height - 0))
            sprite.run(moveGroundSpritesForever)
            backParalax.addChild(sprite)
            backParalax.zPosition = -10
            backParalax.speed = 1
        }
    }
    
    //add Puck
    func addPuck() {
        ballNode.physicsBody = SKPhysicsBody(circleOfRadius: 24)
        ballNode.physicsBody?.categoryBitMask = ballCategory
        ballNode.physicsBody?.contactTestBitMask = paddleCategory + wallCategory + goalCategory + upperLeftCornerCategory + lowerLeftCornerCategory + upperRightCornerCategory + lowerRightCornerCategory
        
        ballNode.physicsBody?.collisionBitMask = paddleCategory + brickCategory + wallCategory + upperLeftCornerCategory + lowerLeftCornerCategory + upperRightCornerCategory + lowerRightCornerCategory + midCategory
            
        ballNode.zPosition = 50
        
        ballNode.physicsBody?.affectedByGravity = true
        ballNode.physicsBody?.isDynamic = true
        ballNode.physicsBody?.allowsRotation = true
        ballNode.physicsBody?.friction = 0
        ballNode.physicsBody?.linearDamping =  0
        ballNode.physicsBody?.angularDamping = 0
        ballNode.physicsBody?.restitution = 1.0
        ballNode.physicsBody?.mass = 0
        ballNode.physicsBody?.fieldBitMask = vortexCategory

        ballNode.name = "ball"
        ballNode.position = CGPoint(x:0,y:0 )
        ballNode.speed = CGFloat(1.0)
        ballNode.physicsBody?.velocity = (CGVector(dx: -250, dy: 750))
        anchorNode.addChild(ballNode)
        
        let ballEmoji = SKLabelNode(fontNamed:"Apple Color Emoji")
        ballEmoji.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        ballEmoji.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        ballEmoji.alpha = 1.0
        ballEmoji.position = CGPoint(x: 0, y: 0)
        ballEmoji.zPosition = 50
        ballEmoji.text = "💿"
        ballEmoji.fontSize = 48
        ballNode.addChild(ballEmoji)
    }
    
    //Starts up the reading the tilemap
    func tileMapRun(TileMapNode: SKTileMapNode, center: CGPoint) {
        let SpriteNode = SKSpriteNode()
        Drawbricks(BricksNode: SpriteNode, TileMapNode: TileMapNode, center: center)
    }
    
    //Draws our Bricks for us
    func Drawbricks(BricksNode: SKSpriteNode, TileMapNode:SKTileMapNode, center: CGPoint) {
        //SpriteNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 48, height: 48))
        BricksNode.physicsBody = SKPhysicsBody(circleOfRadius: 24)
        BricksNode.zPosition = 50
        BricksNode.physicsBody?.restitution = 1.0
        BricksNode.physicsBody?.categoryBitMask = brickCategory
        BricksNode.physicsBody?.collisionBitMask = ballCategory
        
        BricksNode.physicsBody?.fieldBitMask = ballCategory
        BricksNode.physicsBody?.contactTestBitMask = ballCategory
        BricksNode.physicsBody?.allowsRotation = false
        BricksNode.physicsBody?.affectedByGravity = false
        BricksNode.physicsBody?.isDynamic = false
        BricksNode.physicsBody?.pinned = false
        BricksNode.physicsBody?.isResting = false
        BricksNode.physicsBody?.friction = 0.0
        BricksNode.physicsBody?.mass = 1.0
        BricksNode.name = "brick"
        BricksNode.position = center //CHECK THIS OUT
        space.addChild(BricksNode)
        
        let spriteLabelNode = SKLabelNode(fontNamed:"Apple Color Emoji")
        spriteLabelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        spriteLabelNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        spriteLabelNode.alpha = 1.0
        spriteLabelNode.position = CGPoint(x: 0, y: 0)
        var str = "🚘" //future include variants
        spriteLabelNode.fontSize = 48
        
        //future read the tile map emojis instead
        
        var playLevel = gameLevel
        
    
        
        playLevel = gameLevel % 15
        
        
        switch playLevel {
            
        case 1:
            let coinToss = arc4random_uniform(11) + 1
            //print("coinToss",coinToss)
            switch coinToss {
                
            case 1 :
                str = "🚘"
            case 2 :
                str = "🌕"
            case 3 :
                str = "🚀"
            case 4 :
                let coin = arc4random_uniform(2) +  1
                switch coin {
                case 1 :
                    str = "👩🏻‍🚀"
                case 2 :
                    str = "👩‍🚀"
                case 3 :
                    str = "👩🏼‍🚀"
                default:
                    str = "👩🏽‍🚀"
                }
            case 5 :
                let coin = arc4random_uniform(2) +  1
                switch coin {
                case 1 :
                    str = "👨🏻‍🚀"
                case 2 :
                    str = "👨‍🚀"
                case 3 :
                    str = "👨🏼‍🚀"
                default:
                    str = "👨🏽‍🚀"
                }
            case 6 :
                let coin = arc4random_uniform(2) +  1
                switch coin {
                case 1 :
                    str = "🌏"
                case 2 :
                    str = "🌍"
                case 3 :
                    str = "🌎"
                default:
                    str = "🌎"
                }
            case 8 :
                str = "🕹"
            case 9 :
                str = "🖲"
            case 10 :
                str = "🛰"
            case 11 :
                str = "📡"
            default :
                str = "🚀"
            }
            
        case 2:
            let coinToss = arc4random_uniform(10) + 1
            
            switch coinToss {
                
            case 1 :
                str = "🍋"
            case 2 :
                str = "🍎"
            case 3 :
                str = "🍏"
            case 4 :
                str = "🍒"
            case 5 :
                str = "🍓"
            case 6 :
                str = "🍌"
            case 7 :
                str = "🍇"
            case 8 :
                str = "🍊"
            case 9 :
                str = "🍒"
            case 10 :
                str = "🍉"
            default :
                str = "🍎"
            }
            
        case 3:
            let coinToss = arc4random_uniform(13) + 1
            
            switch coinToss {
                
            case 1 :
                str = "🚖"
            case 2 :
                str = "🚔"
            case 3 :
                str = "🚍"
            case 4 :
                str = "🚘"
            case 5 :
                str = "🚕"
            case 6 :
                str = "🚙"
            case 7 :
                str = "🚗"
            case 8 :
                str = "🚜"
            case 9 :
                str = "🚚"
            case 10 :
                str = "🚛"
            case 11 :
                str = "🚌"
            case 12 :
                str = "🚍"
            case 13 :
                str = "🚓"
            default :
                str = "🚒"
            }
            
        case 4:
            let coinToss = arc4random_uniform(12) + 1
            
            switch coinToss {
                
            case 1 :
                str = "👾"
            case 2 :
                str = "👽"
            case 3 :
                str = "🚀"
            case 4 :
                str = "🛰"
            case 5 :
                str = "📡"
            case 6 :
                str = "💫"
            case 7 :
                str = "✨"
            case 8 :
                str = "🌟"
            case 9 :
                str = "⭐️"
            case 10 :
                str = "🚈"
            case 11 :
                str = "🚄"
            case 12 :
                str = "🖲"
            default :
                str = "🖲"
            }
        case 5:
            let coinToss = arc4random_uniform(9) + 1
            
            switch coinToss {
                
            case 1 :
                str = "🏀"
            case 2 :
                str = "🏈"
            case 3 :
                str = "🏉"
            case 4 :
                str = "🏐"
            case 5 :
                str = "⚾️"
            case 6 :
                str = "⚽️"
            case 7 :
                str = "🎾"
            case 8 :
                str = "🎱"
            default :
                str = "🏀"
            }
        case 6:
            let coinToss = arc4random_uniform(12) + 1
            
            switch coinToss {
                
            case 1 :
                str = "🍩"
            case 2 :
                str = "🍪"
            case 3 :
                str = "🍫"
            case 4 :
                str = "🍬"
            case 5 :
                str = "🍭"
            case 6 :
                str = "🍦"
            case 7 :
                str = "🍧"
            case 8 :
                str = "🍨"
            case 9 :
                str = "🍯"
            case 10 :
                str = "🍰"
            case 11 :
                str = "🎂"
            case 12 :
                str = "🥧"
            default :
                str = "🍩"
            }
        case 7:
            let coinToss = arc4random_uniform(13) + 1
            
            switch coinToss {
                
            case 1 :
                str = "🐵"
            case 2 :
                str = "🐶"
            case 3 :
                str = "🐸"
            case 4 :
                str = "🐹"
            case 5 :
                str = "🐻"
            case 6 :
                str = "🐼"
            case 7 :
                str = "🦁"
            case 8 :
                str = "🦊"
            case 9 :
                str = "😸"
            case 10 :
                str = "🐨"
            case 11 :
                str = "🐯"
            case 12 :
                str = "🐮"
            case 13 :
                str = "🐲"
            default :
                str = "🐵"
            }
        case 8:
            let coinToss = arc4random_uniform(18) + 1
            
            switch coinToss {
                
            case 1 :
                str = "💒"
            case 2 :
                str = "🏚"
            case 3 :
                str = "🏠"
            case 4 :
                str = "🏢"
            case 5 :
                str = "🏣"
            case 6 :
                str = "🏤"
            case 7 :
                str = "🏥"
            case 8 :
                str = "🏦"
            case 9 :
                str = "🏨"
            case 10 :
                str = "🏰"
            case 11 :
                str = "🕋"
            case 12 :
                str = "🕌"
            case 13 :
                str = "🕍"
            case 14 :
                str = "🗼"
            case 15 :
                str = "🗽"
            case 16 :
                str = "🏯"
            case 17 :
                str = "🏬"
            case 18 :
                str = "⛪️"
            default :
                str = "🏰"
            }
        case 9:
            let coinToss = arc4random_uniform(18) + 1
            
            switch coinToss {
                
            case 1 :
                str = "😀"
            case 2 :
                str = "😍"
            case 3 :
                str = "😤"
            case 4 :
                str = "😡"
            case 5 :
                str = "😱"
            case 6 :
                str = "🤯"
            case 7 :
                str = "🤓"
            case 8 :
                str = "🤪"
            case 9 :
                str = "😎"
            case 10 :
                str = "🤮"
            case 11 :
                str = "😵"
            case 12 :
                str = "🤒"
            case 13 :
                str = "🤑"
            case 14 :
                str = "😇"
            case 15 :
                str = "😃"
            case 16 :
                str = "😜"
            case 17 :
                str = "☺️"
            case 18 :
                str = "🤩"
            default :
                str = "🤩"
            }
        case 10:
            let coinToss = arc4random_uniform(16) + 1
            
            switch coinToss {
                
            case 1 :
                str = "🍟"
            case 2 :
                str = "🍔"
            case 3 :
                str = "🍕"
            case 4 :
                str = "🌮"
            case 5 :
                str = "🥫"
            case 6 :
                str = "🍞"
            case 7 :
                str = "🥨"
            case 8 :
                str = "🧀"
            case 9 :
                str = "🥚"
            case 10 :
                str = "🍖"
            case 11 :
                str = "🥪"
            case 12 :
                str = "🥤"
            case 13 :
                str = "🥑"
            case 14 :
                str = "🌶"
            case 15 :
                str = "🌽"
            case 16 :
                str = "🥐"
            default :
                str = "🍔"
            }
        case 11:
            let coinToss = arc4random_uniform(24) + 1
            
            switch coinToss {
                
            case 1 :
                str = "👩‍🎨"
            case 2 :
                str = "👨‍🎨"
            case 3 :
                str = "👨‍🌾"
            case 4 :
                str = "👩‍🌾"
            case 5 :
                str = "👩‍🍳"
            case 6 :
                str = "👨‍🍳"
            case 7 :
                str = "👩‍🎓"
            case 8 :
                str = "👨‍🎓"
            case 9 :
                str = "👩‍🎤"
            case 10 :
                str = "👨‍🎤"
            case 11 :
                str = "👩‍💼"
            case 12 :
                str = "👨‍💼"
            case 13 :
                str = "👩‍🔧"
            case 14 :
                str = "👨‍🔧"
            case 15 :
                str = "👩‍🔬"
            case 16 :
                str = "👨‍🔬"
            case 17 :
                str = "👩‍🚒"
            case 18 :
                str = "👨‍🚒"
            case 19 :
                str = "👩‍⚖️"
            case 20 :
                str = "👨‍⚖️"
            case 21 :
                str = "👩‍🎓"
            case 22 :
                str = "👨‍🎓"
            case 23 :
                str = "🕵️‍♂️"
            case 24 :
                str = "🕵️‍♀️"
            default :
                str = "👩‍🚒"
            }
        case 12:
            let coinToss = arc4random_uniform(12) + 1
            
            switch coinToss {
                
            case 1 :
                str = "🧡"
            case 2 :
                str = "❤️"
            case 3 :
                str = "💛"
            case 4 :
                str = "💚"
            case 5 :
                str = "💙"
            case 6 :
                str = "💜"
            case 7 :
                str = "💔"
            case 8 :
                str = "💖"
            case 9 :
                str = "💝"
            case 10 :
                str = "😍"
            case 11 :
                str = "💕"
            case 12 :
                str = "💘"
            default :
                str = "🧡"
            }
        case 13:
            let coinToss = arc4random_uniform(12) + 1
            
            switch coinToss {
                
            case 1 :
                str = "⏰"
            case 2 :
                str = "⏱"
            case 3 :
                str = "⏳"
            case 4 :
                str = "⌛️"
            case 5 :
                str = "⏲"
            case 6 :
                str = "🕰"
            case 7 :
                str = "🛡"
            case 8 :
                str = "📻"
            case 9 :
                str = "📺"
            case 10 :
                str = "☎️"
            case 11 :
                str = "📠"
            case 12 :
                str = "📟"
            default :
                str = "⏰"
            }
        case 14:
            let coinToss = arc4random_uniform(21) + 1
            
            switch coinToss {
                
            case 1 :
                str = "🧙‍♀️"
            case 2 :
                str = "🧙‍♂️"
            case 3 :
                str = "🧝‍♀️"
            case 4 :
                str = "🧝‍♂️"
            case 5 :
                str = "🧛‍♀️"
            case 6 :
                str = "🧛‍♂️"
            case 7 :
                str = "🧟‍♀️"
            case 8 :
                str = "🧟‍♂️"
            case 9 :
                str = "🧞‍♀️"
            case 10 :
                str = "🧞‍♂️"
            case 11 :
                str = "🧜‍♀️"
            case 12 :
                str = "🧜‍♂️"
            case 13 :
                str = "🧚‍♀️"
            case 14 :
                str = "🧚‍♂️"
            default :
                str = "🧟‍♀️"
            }
        case 15:
            let coinToss = arc4random_uniform(19) + 1
            
            switch coinToss {
                
            case 1 :
                str = "🌈"
            case 2 :
                str = "🏰"
            case 3 :
                str = "🦄"
            case 4 :
                str = "🐴"
            case 5 :
                str = "🔮"
            case 6 :
                str = "👑"
            case 7 :
                str = "🤴"
            case 8 :
                str = "👸"
            case 9 :
                str = "👸🏻"
            case 10 :
                str = "🤴🏻"
            case 11 :
                str = "🤴🏼"
            case 12 :
                str = "👸🏼"
            case 13 :
                str = "👸🏽"
            case 14 :
                str = "🤴🏽"
            case 15 :
                str = "🛡"
            case 16 :
                str = "🗡"
            case 17 :
                str = "⚔️"
            case 18 :
                str = "🤺"
            case 19 :
                str = "🍀"
            case 20 :
                str = "☘️"
            default :
                str = "🦄"
            }
        
        default:
            let coinToss = arc4random_uniform(14) + 1
            
            switch coinToss {
                
            case 1 :
                str = "🥃"
            case 2 :
                str = "🥛"
            case 3 :
                str = "🥤"
            case 4 :
                str = "🍻"
            case 5 :
                str = "🍾"
            case 6 :
                str = "🍵"
            case 7 :
                str = "🍶"
            case 8 :
                str = "🍷"
            case 9 :
                str = "🍸"
            case 10 :
                str = "🍹"
            case 11 :
                str = "🍺"
            case 13 :
                str = "🍼"
            case 14 :
                str = "☕️"
            default :
                str = "🍺"
            }
        }
        
        spriteLabelNode.text = str
        BricksNode.addChild(spriteLabelNode)
        
    }
    
    func drawBricks(BricksTileMap: SKTileMapNode) {

        brickCounter = 0 //reset bricks
        for col in (0 ..< BricksTileMap.numberOfColumns) {
            
            for row in (0 ..< BricksTileMap.numberOfRows) {
                let tileDefinition = BricksTileMap.tileDefinition(atColumn: col, row: row)
                
                //print(center)
                if (tileDefinition !== nil) {
                    brickCounter = brickCounter + 1
                    let center = BricksTileMap.centerOfTile(atColumn: col, row: row)
                    tileMapRun(TileMapNode: BricksTileMap, center: center)
                }
            }
        }

        BricksTileMap.alpha = 0
        
    }
    
    override func didMove(to view: SKView) {
        self.view?.isMultipleTouchEnabled = false
        
        width = self.frame.width
        height = self.frame.height
        
        centerWidth = width / 2
        centerHeight = height / 2
        
        //stand in for our anchorPoint
        //this is used because our scene's anchor is 0,0
        //for the field node to work properly
        anchor = CGPoint(x: centerWidth ,y: centerHeight)
        anchorNode.position = anchor
        self.addChild(anchorNode)
        
        //iPhone X
        if deviceType == .iPhoneX {
           height = (self.frame.height - 144)
           centerHeight = height / 2
        } else if
            deviceType == .iPad {
            ipadString = "-ipad";
        }
        
    
        
        //print(settings)
       
        
        ///drawbricks here
        drawLevel()
        
        scene?.speed = 1.0
       
        livesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        livesLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        livesLabel.alpha = 1.0
        livesLabel.position = CGPoint(x: centerWidth - labeledges, y: centerHeight - labelspace)
        livesLabel.zPosition = 50
        livesLabel.text = String(gameLives)
        livesLabel.fontSize = 36
        livesLabel.fontColor = UIColor.init(red: 247 / 255, green: 147 / 255, blue: 30 / 255, alpha: 1.0)
        livesLabel.alpha = 1.0
        anchorNode.addChild(livesLabel)
        
        levelLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        levelLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        levelLabel.alpha = 1.0
        levelLabel.position = CGPoint(x: (-centerWidth + labeledges), y: centerHeight - labelspace)
        levelLabel.zPosition = 50
        levelLabel.text = String(gameLevel)
        levelLabel.fontSize = 36
        levelLabel.fontColor = UIColor.init(red: 16 / 255, green: 125 / 255, blue: 1.0, alpha: 1.0)
        levelLabel.alpha = 1.0
        anchorNode.addChild(levelLabel)
        
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        scoreLabel.alpha = 1.0
        scoreLabel.position = CGPoint(x: 0, y: centerHeight - labelspace)
        scoreLabel.zPosition = 50
        scoreLabel.text = String(gameScore)
        scoreLabel.fontSize = 36
        scoreLabel.alpha = 0.95

        anchorNode.addChild(scoreLabel)
        
        drawBricks(BricksTileMap: bricksTileMap)
    
        /*
         let barrierNode = SKNode()
        let f = CGRect(x: -centerWidth + 24, y: 200 , width: width - 48, height: (height / 4) + 24)
         barrierNode.physicsBody = SKPhysicsBody(edgeLoopFrom: f)
         barrierNode.physicsBody?.categoryBitMask = barrierCategory
         barrierNode.physicsBody?.fieldBitMask = 0

        anchorNode.addChild(barrierNode)
        */
        
        
        let frame = CGRect(x: -centerWidth, y: -centerHeight, width: width + 1, height: height - 55)
        //border for the paddle, ball and our beer
        let wallNode = SKNode()
        wallNode.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        wallNode.physicsBody?.isDynamic = false
        wallNode.physicsBody?.restitution = 0
        wallNode.name = "wall"
        wallNode.position = CGPoint(x: 0, y: 0)
        wallNode.physicsBody?.contactTestBitMask = ballCategory + paddleCategory
        wallNode.physicsBody?.allowsRotation = false
        wallNode.physicsBody?.categoryBitMask = wallCategory
        anchorNode.addChild(wallNode)
        
        //setup physicsWorld
        self.physicsWorld.gravity = CGVector(dx: 0.00, dy: -0.25)
        scene?.physicsWorld.contactDelegate = self
        
        //Setup our Vortex
        
        let field = SKFieldNode.vortexField()
        field.strength = 1
        field.falloff = -0.1
        field.minimumRadius = Float((height / 4))
        field.xScale = 1.0
        field.yScale = -1.0
        field.zPosition = -100

        field.position = CGPoint(x:0,y:0)
        field.physicsBody?.affectedByGravity = false //true
        field.physicsBody?.isDynamic = false //false
        field.physicsBody?.categoryBitMask = vortexCategory
        field.physicsBody?.fieldBitMask = ballCategory
        field.physicsBody?.restitution = 0
        anchorNode.addChild(field)
        
        
        //left mid corner piece
        let leftMidNode = SKSpriteNode()
        let leftMidTexture = SKTexture(imageNamed: "leftmid")
        let leftMidBody =  SKPhysicsBody(texture: leftMidTexture, alphaThreshold: 0.1, size: leftMidTexture.size())
        leftMidNode.texture = leftMidTexture
        leftMidNode.physicsBody = leftMidBody
        leftMidNode.physicsBody?.friction = 0
        leftMidNode.physicsBody?.fieldBitMask = 0
        leftMidNode.physicsBody?.contactTestBitMask = ballCategory
        leftMidNode.physicsBody?.categoryBitMask = midCategory
        leftMidNode.physicsBody?.collisionBitMask = midCategory + ballCategory
        leftMidNode.physicsBody?.restitution = 1.0
        leftMidNode.physicsBody?.mass = 1
        leftMidNode.physicsBody?.isDynamic = false
        leftMidNode.physicsBody?.affectedByGravity = false
        leftMidNode.size = CGSize(width: 32, height: 64)
        leftMidNode.position = CGPoint(x: -centerWidth + (corneredge / 2),y: 0)
        anchorNode.addChild(leftMidNode)
        
        
        //right mid corner piece
        let rightMidNode = SKSpriteNode()
        let rightMidTexture = SKTexture(imageNamed: "rightmid")
        let rightMidBody =  SKPhysicsBody(texture: rightMidTexture, alphaThreshold: 0.1, size: rightMidTexture.size())
        rightMidNode.texture = rightMidTexture
        rightMidNode.physicsBody = rightMidBody
        rightMidNode.physicsBody?.friction = 0
        rightMidNode.physicsBody?.fieldBitMask = 0
        rightMidNode.physicsBody?.contactTestBitMask = ballCategory
        rightMidNode.physicsBody?.categoryBitMask = midCategory
        rightMidNode.physicsBody?.collisionBitMask = midCategory + ballCategory
        rightMidNode.physicsBody?.restitution = 1.0
        rightMidNode.physicsBody?.mass = 1
        rightMidNode.physicsBody?.isDynamic = false
        rightMidNode.physicsBody?.affectedByGravity = false
        rightMidNode.size = CGSize(width: 32, height: 64)
        
        if deviceType == .iPhoneX {
            rightMidNode.position = CGPoint(x: centerWidth - (corneredge / 2),y: 0)
        } else {
            rightMidNode.position = CGPoint(x: centerWidth - (corneredge / 2),y: 0)
        }
        
        anchorNode.addChild(rightMidNode)
        
        //centercourt circle
        let centerCourtNode = SKSpriteNode()
        let centerCourtTexture = SKTexture(imageNamed: "centercourt")
        centerCourtNode.texture = centerCourtTexture;
        centerCourtNode.size = centerCourtTexture.size();
        centerCourtNode.position = CGPoint(x:0,y:0);
     
        anchorNode.addChild(centerCourtNode)
        
        //centercourt line
        let centerCourtLineNode = SKSpriteNode()
        let centerCourtLineTexture = SKTexture(imageNamed: "centerline")
        centerCourtLineNode.texture = centerCourtLineTexture;
        centerCourtLineNode.size = CGSize(width: (-centerWidth * 2) + 64, height: 4)
        centerCourtLineNode.position = CGPoint(x:0,y:0);
        anchorNode.addChild(centerCourtLineNode)
        
        
        //lower left corner
        let lowerLeftNode = SKSpriteNode()
        let lowerLeftTexture = SKTexture(imageNamed: "ll")
        let lowerLeftBody =  SKPhysicsBody(texture: lowerLeftTexture, alphaThreshold: 0.1, size: lowerLeftTexture.size())
        lowerLeftNode.texture = lowerLeftTexture
        lowerLeftNode.physicsBody = lowerLeftBody
        lowerLeftNode.physicsBody?.friction = 0
        lowerLeftNode.physicsBody?.fieldBitMask = 0
        lowerLeftNode.physicsBody?.contactTestBitMask = ballCategory
        lowerLeftNode.physicsBody?.categoryBitMask = lowerLeftCornerCategory
        lowerLeftNode.physicsBody?.collisionBitMask = lowerLeftCornerCategory + ballCategory
        lowerLeftNode.physicsBody?.restitution = 1.0
        lowerLeftNode.physicsBody?.mass = 1
        lowerLeftNode.physicsBody?.isDynamic = false
        lowerLeftNode.physicsBody?.affectedByGravity = false
        lowerLeftNode.size = CGSize(width: 64, height: 64)
        lowerLeftNode.position = CGPoint(x: -centerWidth + corneredge,y: -centerHeight + 32)
        anchorNode.addChild(lowerLeftNode)
        
        //lower right corner
        let lowerRightNode = SKSpriteNode()
        let lowerRightTexture = SKTexture(imageNamed: "lr")
        let lowerRightBody =  SKPhysicsBody(texture: lowerRightTexture, alphaThreshold: 0.1, size: lowerRightTexture.size())
        lowerRightNode.texture = lowerRightTexture
        lowerRightNode.physicsBody = lowerRightBody
        lowerRightNode.physicsBody?.friction = 0
        lowerRightNode.physicsBody?.fieldBitMask = 0
        lowerRightNode.physicsBody?.contactTestBitMask = ballCategory
        lowerRightNode.physicsBody?.categoryBitMask = lowerRightCornerCategory
        lowerRightNode.physicsBody?.collisionBitMask = lowerRightCornerCategory + ballCategory
        lowerRightNode.physicsBody?.restitution = 1.0
        lowerRightNode.physicsBody?.mass = 1
        lowerRightNode.physicsBody?.isDynamic = false
        lowerRightNode.physicsBody?.affectedByGravity = false
        lowerRightNode.size = CGSize(width: 64, height: 64)
        lowerRightNode.position = CGPoint(x:centerWidth - corneredge,y: -centerHeight + 32)
        anchorNode.addChild(lowerRightNode)
        
        
        
        //upper left corner
        let upperLeftNode = SKSpriteNode()
        let upperLeftTexture = SKTexture(imageNamed: "ul")
        let upperLeftBody =  SKPhysicsBody(texture: upperLeftTexture, alphaThreshold: 0.1, size: upperLeftTexture.size())
        upperLeftNode.texture = upperLeftTexture
        upperLeftNode.physicsBody = upperLeftBody
        upperLeftNode.physicsBody?.friction = 0
        upperLeftNode.physicsBody?.fieldBitMask = 0
        upperLeftNode.physicsBody?.contactTestBitMask = ballCategory
        upperLeftNode.physicsBody?.categoryBitMask = upperLeftCornerCategory
        upperLeftNode.physicsBody?.collisionBitMask = upperLeftCornerCategory + ballCategory
        upperLeftNode.physicsBody?.restitution = 1.0
        upperLeftNode.physicsBody?.mass = 1
        upperLeftNode.physicsBody?.isDynamic = false
        upperLeftNode.physicsBody?.affectedByGravity = false
        upperLeftNode.size = CGSize(width: 64, height: 64)
        upperLeftNode.position = CGPoint(x: -centerWidth + corneredge,y:centerHeight - cornertopedge)
        anchorNode.addChild(upperLeftNode)
        
        //Upper Right Corner
        let upperRightNode = SKSpriteNode()
        let upperRightTexture = SKTexture(imageNamed: "ur")
        let upperRightBody =  SKPhysicsBody(texture: upperRightTexture, alphaThreshold: 0.1, size: upperRightTexture.size())
        upperRightNode.texture = upperRightTexture
        upperRightNode.physicsBody = upperRightBody
        upperRightNode.physicsBody?.friction = 0
        upperRightNode.physicsBody?.fieldBitMask = 0
        upperRightNode.physicsBody?.contactTestBitMask = ballCategory
        upperRightNode.physicsBody?.categoryBitMask = upperRightCornerCategory
        upperRightNode.physicsBody?.collisionBitMask = upperRightCornerCategory + ballCategory
        upperRightNode.physicsBody?.restitution = 1.0
        upperRightNode.physicsBody?.mass = 1
        upperRightNode.physicsBody?.isDynamic = false
        upperRightNode.physicsBody?.affectedByGravity = false
        upperRightNode.size = CGSize(width: 64, height: 64)
        upperRightNode.position = CGPoint(x:centerWidth - corneredge,y:centerHeight - cornertopedge)
        anchorNode.addChild(upperRightNode)
        
        //add our paddle
        let paddleTexture = SKTexture(imageNamed: "paddle")
        let paddlePhysicsBody = SKPhysicsBody(texture: paddleTexture, alphaThreshold: 0.1, size: paddleTexture.size())
        
        paddleNode.texture = paddleTexture
        paddleNode.physicsBody = paddlePhysicsBody
        paddleNode.physicsBody?.friction = 1
        paddleNode.physicsBody?.allowsRotation = false
        paddleNode.physicsBody?.linearDamping = 1
        paddleNode.physicsBody?.angularDamping = 1
        paddleNode.zPosition = 50
        paddleNode.physicsBody?.isDynamic = false
        paddleNode.physicsBody?.fieldBitMask = 0
        paddleNode.physicsBody?.affectedByGravity = false
        paddleNode.physicsBody?.mass = 100
        paddleNode.physicsBody?.contactTestBitMask = ballCategory
        paddleNode.physicsBody?.categoryBitMask = paddleCategory
        paddleNode.physicsBody?.collisionBitMask = ballCategory

        //leave as is for now until we decide to use convert point or not
        
        paddleNode.position = CGPoint(x:self.frame.width / 2,y:self.frame.height / paddleHeight)
        paddleNode.size = CGSize(width: 180.0, height: 40.0) //Needed to size
        paddleNode.physicsBody?.restitution = 0.0
        paddleNode.name = "paddle"
        scene?.addChild(paddleNode)
        
        /*
        let rangeX = SKRange(lowerLimit: 48, upperLimit:  self.frame.width - (48 * 2))
        let rangeY = SKRange(lowerLimit: (self.frame.height / 4) - 20, upperLimit: (self.frame.height / 4) - 20)

        let lockToCenter = SKConstraint.positionX(rangeX, y: rangeY)
        
        paddleNode.constraints = [ lockToCenter ]
        */
        
        /*
        let barrierNode = SKNode()
        let f = CGRect(x: 48, y: self.frame.height / 4 - 42, width: self.frame.width - (48 * 2), height: 42)
        barrierNode.physicsBody = SKPhysicsBody(edgeLoopFrom: f)
        barrierNode.physicsBody?.categoryBitMask = barrierCategory

        scene?.addChild(barrierNode)
        */
        
        //add the Ball
        addPuck()
        
        //add our paddle
        let goalTexture = SKTexture(imageNamed: "goal")
        
        let goalPhysicsBody = SKPhysicsBody(texture: goalTexture, alphaThreshold: 0.1, size: goalTexture.size())
        
        goalNode.texture = goalTexture
        goalNode.physicsBody = goalPhysicsBody
        goalNode.physicsBody?.affectedByGravity = false
        goalNode.physicsBody?.friction = 0
        goalNode.physicsBody?.allowsRotation = false
        goalNode.physicsBody?.linearDamping = 0
        goalNode.physicsBody?.angularDamping = 0
        goalNode.zPosition = 50
        goalNode.physicsBody?.isDynamic = false
        goalNode.physicsBody?.mass = 0.0
        goalNode.physicsBody?.contactTestBitMask = ballCategory
        goalNode.physicsBody?.categoryBitMask = goalCategory
        goalNode.position = CGPoint(x:0,y:-centerHeight)
        goalNode.size = CGSize(width: goalTexture.size().width, height: goalTexture.size().height) //Needed to size
        goalNode.physicsBody?.restitution = 0
        goalNode.name = "goal"
    
        anchorNode.addChild(goalNode)
        
        drawParallax()
        
       /*
        if let soundURL: URL = Bundle.main.url(forResource: "david", withExtension: "mp3") {
            audioPlayer = try! AVAudioPlayer(contentsOf: soundURL)
            audioPlayer.play()
        }
        */
      
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
        let constraint = CGFloat(128)
        if (pos.x >= constraint && pos.x <= self.frame.width - constraint) {
            let action = SKAction.moveTo(x: pos.x, duration: 0.002)
            paddleNode.run(action)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
         let constraint = CGFloat(128)
        if (pos.x >= constraint && pos.x <= self.frame.width - constraint) {
            let action = SKAction.moveTo(x: pos.x, duration: 0.002)
            paddleNode.run(action)
        }
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func resetGameBoard(firstBody: SKPhysicsBody) {
        //clear the board
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 0.25)
        let wait = SKAction.wait(forDuration: 0.25)
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: 0.25)
        let s = space
        let r = SKAction.run {
            s.removeAllChildren()
        }
        
        let d = SKAction.run {
            self.drawBricks(BricksTileMap: self.bricksTileMap)
        }
        
        
        let seq = SKAction.sequence([fadeOut,r,wait,d,fadeIn])
        space.run(seq)
        
        //Reset the puck
        if let puck = firstBody.node {
            let removePuckresetBricks = SKAction.run {
                puck.removeFromParent()
            }
            
            let wait = SKAction.wait(forDuration: 1.0)
            
            let addPuck = SKAction.run {
                self.addPuck()
            }
            
            self.run(SKAction.sequence([removePuckresetBricks, wait, addPuck]))
        }
    }
    //MARK: didBeginContact
    func didBegin(_ contact: SKPhysicsContact) {
        
    
        //print(contact.bodyA.categoryBitMask, contact.bodyB.categoryBitMask)

        if  ( contact.bodyA.node == nil || contact.bodyB.node == nil ) {
            return
        }
        
        
        // Defaults for bodyA and BodyB
        var firstBody = contact.bodyB
        var secondBody = contact.bodyA
        
        if contact.bodyB.categoryBitMask > contact.bodyA.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        let catMask = firstBody.categoryBitMask | secondBody.categoryBitMask
        
        //print(firstBody.categoryBitMask,secondBody.categoryBitMask)
        
        switch catMask {

        case ballCategory | brickCategory :
            
            self.run(brickSound)
            
            if let a = secondBody.node {
                
                gameScore = gameScore + 1
                scoreLabel.text = String(gameScore)
                brickCounter = brickCounter - 1
                let action = SKAction.removeFromParent()
                
                a.run(action)
            }
            
            if let b = firstBody.node {
                
                if brickCounter <= 0 {
                    b.removeFromParent()
                } else {
                    //let ballaction = SKAction.applyImpulse( CGVector(dx: 0 , dy: -25), duration: 1)
                    // b.run(ballaction)
                }
            }
            
            //Levels Up
            if brickCounter <= 0 {
                
                gameLevel += 1
                levelLabel.text = String(gameLevel)

                gameLives += 1
                livesLabel.text = String(gameLives)


                //Reset
                resetGameBoard(firstBody: firstBody)
            }
            
        case ballCategory | wallCategory  :
            
            self.run(wallSound)
            
            let cp = contact.contactPoint
            
            if cp.x < 0 {
                if let a = firstBody.node {
                    let ballaction = SKAction.applyImpulse( CGVector(dx: 50 , dy: 0), duration: 2)
                    a.run(ballaction)
                }
            } else {
                if let a = firstBody.node {
                    let ballaction = SKAction.applyImpulse( CGVector(dx: -50 , dy: 0), duration: 2)
                    a.run(ballaction)
                }
            }
        case ballCategory | midCategory :
            
            self.run(wallSound)
            gameScore += 2
            self.run(wallSound)

        case midCategory | ballCategory :
            
            self.run(wallSound)
            gameScore += 2
            self.run(wallSound)

        case ballCategory | goalCategory :
            
         
            self.run(goalSound)
            
            //remove the puck
            if let puck = firstBody.node {
                //lives to come
                
                gameLives = gameLives - 1
                livesLabel.text = String(gameLives)

                let action1 = SKAction.run {
                    puck.removeFromParent()
                }
                
                let action2 = SKAction.wait(forDuration: 0.5)
                
                let action3 = SKAction.run {
                    self.addPuck()
                }
        
                if gameLives > 0 {
                    livesLabel.text = String(gameLives)
                    self.run(SKAction.sequence([action1, action2, action3]))
                } else {
                    //game over sequence
                    
                    resetGameBoard(firstBody: firstBody)

                    //reset labels
                    brickCounter = 0
                    gameLives = 9
                    livesLabel.text = String(gameLives)
                    
                    gameLevel = 1
                    levelLabel.text = String(gameLevel)
                    
                    gameScore = 0
                    scoreLabel.text = String(gameScore)
                    
                }
            }
            
            
        case paddleCategory | ballCategory :
         
            self.run(paddleSound)
          
            if let a = firstBody.node {
                let ballaction = SKAction.applyImpulse( CGVector(dx: 0 , dy: 75), duration: 1)
                a.run(ballaction)
            }
            
        case ballCategory | lowerLeftCornerCategory :
            
            self.run(wallSound)
            
            if let a = firstBody.node {
                let ballaction = SKAction.applyImpulse( CGVector(dx: 25 , dy: 50), duration: 2)
                a.run(ballaction)
            }
            
        case ballCategory | upperLeftCornerCategory :
            
            self.run(wallSound)
            
            if let a = firstBody.node {
                let ballaction = SKAction.applyImpulse( CGVector(dx: 25 , dy: -50), duration: 2)
                a.run(ballaction)
            }
        
        case ballCategory | lowerRightCornerCategory :
            
            self.run(wallSound)
            
            if let a = firstBody.node {
                let ballaction = SKAction.applyImpulse( CGVector(dx: -25 , dy: 50), duration: 2)
                a.run(ballaction)
            }
            
        case ballCategory | upperRightCornerCategory :
            
            self.run(wallSound)
            
            if let a = firstBody.node {
                let ballaction = SKAction.applyImpulse( CGVector(dx: -25 , dy: -50), duration: 2)
                a.run(ballaction)
            }
            
        default :
            return
        }
    }
}
