//
//  Global.swift
//  Space-Bar
//
//  Created by Todd Bruss on 10/5/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import AVFoundation

struct MoveState {
    static var shared = MoveState()
    var moveLeft: Bool  = false
    var moveRight: Bool = false
}

struct Global {
    static var shared = Global()
    let gameBall: [String] = ["🤩","🥳","😏","😒","😞","😔","😟","😕"]
    let gameBallText: Array = ["blue","fuchsia","warm red","orange","magenta","bright green","green","purple rain"]
    var rotation = [315.0, 270.0, 225.0, 180.0, 135.0, 90.0, 45.0, 0.0]
    let soundFx: Array = ["🔇","🔊"]
    let soundFxText: Array = ["no sound fx","sound fx"]
    var levels = [
                  //1     2     3     4     5     6     7     8
                  "😕", "🥸", "😛", "🤣", "😟", "😎", "😋", "😂",
                  "😔", "🤓", "😚", "😅", "😞", "🧐", "😙", "😆", //16
                  "😒", "🤨", "😗", "😁", "😏", "🤪", "😘", "😄", //24
                  "🥳", "😜", "🥰", "😃", "🤩", "😝", "😍", "😀", //32
                  
                  "😕", "🥸", "😛", "🤣", "😟", "😎", "😋", "😂", //40
                  "😔", "🤓", "😚", "😅", "😞", "🧐", "😙", "😆", //48
                  "😒", "🤨", "😗", "😁", "😏", "🤪", "😘", "😄", //56
                  "🥳", "😜", "🥰", "😃", "🤩", "😝", "😍", "😀", //64
                  
                  "😕", "🥸", "😛", "🤣", "😟", "😎", "😋", "😂", //72
                  "😔", "🤓", "😚", "😅", "😞", "🧐", "😙", "😆", //80
                  "😒", "🤨", "😗", "😁", "😏", "🤪", "😘", "😄", //88
                  "🥳", "😜", "🥰", "😃", "🤩", "😝", "😍", "😀", //96
                  "🥳", "😜", "🥰", "😃", //100
                  ]
    var initialScreenSize: CGSize?
    let constraint = CGFloat(64)
    let windspeed: Double = 0.15
    let movement: Double = 10
    let moveLeft: String = "moveLeft"
    let moveRight: String = "moveRight"
    var showCursor: Bool = true
    var runningGame: Bool = false
}

// Global Vars used outside, some are required
var settings = Settings() 
var initialScreenSize = CGSize()
var yCoverMacOS = CGFloat(0)
var windowWidth = CGFloat(0)
var windowHeight = CGFloat(0)
var widthiOS = CGFloat(650)
var heightiOS = CGFloat(1300)
var displayIsRetina: Bool = false
var displayDensity: Double = 1.0
var resettingGameBoard = false
var gScene = SKScene()
var g = Global.shared
var gameSceneDelegate: GameSceneDelegate! //required
var paddleNode = SKSpriteNode() //required
let synthesizer = AVSpeechSynthesizer()
var gFireBallNode = SKSpriteNode()
var pauseLabel = SKLabelNode(fontNamed:"AppleColorEmoji")

struct LeaderBoard: Codable {
    var  score      : Int
    var  playerName : String
    var `start`     : Int
    var `stop`      : Int
    var  date       : Date
}

var leaderBoard = [LeaderBoard]()
