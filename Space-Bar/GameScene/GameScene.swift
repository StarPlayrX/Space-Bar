//
//  GameScene.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/29/22.
//

import SpriteKit

class GameScene: SKScene {
    
    let paddle = CGFloat(120)
    let center = CGFloat(2)
    let leftBorder = CGFloat(4)
    let rightBorder = CGFloat(2)
    let xOffset = CGFloat(34)
    let xTimer = CGFloat(0.03)
    
    var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    var gameOver: Bool?
    var ballCounter = 10
    let ballTimeOut = 5
    var timer = Timer()
    let ratio = CGFloat(2)
    let zero = CGFloat(0)
    
    var velocity    = CGFloat(700)    
    var ballNode    = SKSpriteNode()
    var extraNode   = SKSpriteNode()
    var tennisNode  = SKSpriteNode()
    
    let appSettings = AppSettings()
    
    deinit {
        removeAllActions()
        removeAllChildren()
        removeFromParent()
    }
    
    // Our Game's Actors
    var bricksChecksum = 0
    var bricksChecksumPrev = 1
    var swapper = false
    var swapper2 = false
    var swapper3 = false
    
    //Categories
    let paddleCategory   : UInt32 = 2
    let fireBallCategory : UInt32 = 4
    let powerCategory    : UInt32 = 8
    let ballCategory     : UInt32 = 16
    let brickCategory    : UInt32 = 32
    let wallCategory     : UInt32 = 64
    let goalCategory     : UInt32 = 128
    let midFieldCategory : UInt32 = 256
    let middieCategory   : UInt32 = 512
    
    var space : SKReferenceNode? = nil
    
    //Positioning variables
    var anchor = CGPoint()
    var anchorNode = SKNode()
    var width = CGFloat()
    var height = CGFloat()
    var centerWidth = CGFloat()
    var centerHeight = CGFloat()
    
    //Initial Variables
    var gameScore  = Int(0)
    var gameLives  = Int(settings.lives)
    let scoreLabel = SKLabelNode(fontNamed:"emulogic")
    let levelLabel = SKLabelNode(fontNamed:"emulogic")
    let livesLabel = SKLabelNode(fontNamed:"SpaceBarColors")
    
    //MARK: New Bug on iOS 16.1 - Simulator gets a deadlock when trying to play sounds
#if targetEnvironment(simulator)
    let goalSound   = SKAction()
    let brickSound  = SKAction()
    let wallSound   = SKAction()
    let paddleSound = SKAction()
#else
    let goalSound   = SKAction.playSoundFileNamed("Dah.mp3", waitForCompletion: false)
    let brickSound  = SKAction.playSoundFileNamed("Bip.mp3", waitForCompletion: false)
    let wallSound   = SKAction.playSoundFileNamed("Dat.mp3", waitForCompletion: false)
    let paddleSound = SKAction.playSoundFileNamed("Knock.mp3", waitForCompletion: false)
#endif
    
    //corners
    let corneredge    = CGFloat(32)
    let cornertopedge = CGFloat(86)
    
    //labels
    let labelspace = CGFloat(28)
    let labeledges = CGFloat(65)
    
    //paddleHeight
    var paddleHeight = CGFloat(4)
    
    //ipad Level
    var screenType: ScreenType = .iAny
    
    //Our custom font maps emoji's to vector graphics - same technique is done on old school to classic 8 bit games
    var levelart : [ Int : [String] ] =
    [
        0: ["🤩", "🥳", "😏", "😒", "😞", "😔", "😟", "😕"],
        1: ["😝", "😜", "🤪", "🤨", "🧐", "🤓", "😎", "🥸"],
        2: ["😍", "🥰", "😘", "😗", "😙", "😚", "😋", "😛"],
        3: ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣"],
    ]
}
