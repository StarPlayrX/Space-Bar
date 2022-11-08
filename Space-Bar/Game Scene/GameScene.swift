//
//  GameScene.swift
//  Space Bar
//
//  Created by Todd Bruss on 10/5/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate { // AVAudioPlayerDelegate //AVSpeechSynthesizerDelegate
    
    var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    var gameOver: Bool?
    var ballCounter = 10
    let ballTimeOut = 10
    var timer = Timer()
    
    let boost = CGFloat(15)
    let ratio = CGFloat(1.5)
    let zero = CGFloat(0)
    var initialVelocity = CGFloat(800)
    let differentiator = CGFloat(250)
    
    var ballNode    = SKSpriteNode()
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
    var paddleNode: SKSpriteNode? //available to the entire class
    
    //Categories
    let paddleCategory   : UInt32 = 1
    let powerCategory    : UInt32 = 2
    let ballCategory     : UInt32 = 4
    let brickCategory    : UInt32 = 8
    let wallCategory     : UInt32 = 16
    let goalCategory     : UInt32 = 32
    let midFieldCategory : UInt32 = 64
    
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
    
    let goalSound   = SKAction.playSoundFileNamed("Dah.mp3", waitForCompletion: false)
    let brickSound  = SKAction.playSoundFileNamed("Bip.mp3", waitForCompletion: false)
    let paddleSound = SKAction.playSoundFileNamed("Knock.mp3", waitForCompletion: false)
    let wallSound   = SKAction.playSoundFileNamed("Dat.mp3", waitForCompletion: false)
    
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
    var levelart = [ Int : [String] ]()
    
    //MARK: - Cocoa Touch
    let constraint = CGFloat(64)
}
