//
//  GameScene.swift
//  Space Bar
//
//  Created by Todd Bruss on 2/5/18.
//  Copyright © 2018 Todd Bruss. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate, AVSpeechSynthesizerDelegate { // AVAudioPlayerDelegate
    
    var gameOver: Bool?
    
    let boost = CGFloat(15)
    let ratio = CGFloat(1.5)
    let halfLife = CGFloat(2)
    let zero = CGFloat(0)
    var initialVelocity = CGFloat(800)
    let differentiator = CGFloat(250)
    
    var ballNode: SKSpriteNode? = nil
    let appSettings = AppSettings()
    
    deinit {
        removeAllActions()
        removeAllChildren()
        removeFromParent()
        print("Game Scene deinit")
    }
    
    func setHighScore() {
        settings.highscore = gameScore > settings.highscore ? gameScore : settings.highscore
        settings.highlevel = settings.currentlevel > settings.highlevel ? settings.currentlevel : settings.highlevel
    }
    
    // Our Game's Actors
    var bricksChecksum = 0
    var bricksChecksumPrev = 1
    var swapper = false
    var paddleNode: SKSpriteNode? //available to the entire class
    
    //Categories
    let paddleCategory = UInt32(1)
    let powerCategory = UInt32(2)
    let ballCategory = UInt32(4)
    let brickCategory = UInt32(8)
    let wallCategory = UInt32(16)
    let goalCategory = UInt32(32)
    var space : SKReferenceNode? = nil
    
    //Positioning variables
    var anchor = CGPoint()
    var anchorNode = SKNode()
    var width = CGFloat()
    var height = CGFloat()
    var centerWidth = CGFloat()
    var centerHeight = CGFloat()
    
    //Initial Variables
    var gameScore = Int(0)
    var gameLives = Int(settings.lives)
    let scoreLabel = SKLabelNode(fontNamed:"emulogic")
    let levelLabel = SKLabelNode(fontNamed:"emulogic")
    let livesLabel = SKLabelNode(fontNamed:"emulogic")
    
    let goalSound = SKAction.playSoundFileNamed("Dah.mp3", waitForCompletion: false)
    let brickSound = SKAction.playSoundFileNamed("Bip.mp3", waitForCompletion: false)
    let paddleSound = SKAction.playSoundFileNamed("Knock.mp3", waitForCompletion: false)
    let wallSound = SKAction.playSoundFileNamed("Dat.mp3", waitForCompletion: false)
    
    //corners
    let corneredge = CGFloat(32)
    let cornertopedge = CGFloat(86)
    
    //labels
    let labelspace = CGFloat(28)
    let labeledges = CGFloat(65)
    
    //paddleHeight
    var paddleHeight = CGFloat(4)
    
    //ipad Level
    var screenType: ScreenType = .iAny
    var levelart = [ Int : [String] ]()
    
    func drawLevel() {
        let lvlStr = String(settings.currentlevel + 1)
        
        let filename = "level\(lvlStr).sks"
        
        space = SKReferenceNode(fileNamed: filename)
        space?.name = "Space"
        
        guard let tilemap = space?.childNode(withName: "//bricks") as? SKTileMapNode else { return }
        
        for center in children {
            if (center.name == "Center") {
                guard let space = space else { return }
                center.position = CGPoint(x: centerWidth, y: centerHeight)
                center.addChild(space)
                break
            }
        }
       
        drawBricks(BricksTileMap: tilemap)
       
        var x: CGFloat = 0
        
        if xPos.indices.contains(settings.currentlevel) {
            x = xPos[settings.currentlevel] * 12.5
        }
        
        space?.position = screenType == .iPad ? CGPoint(x: x, y: centerHeight - 400 / 1.80) : CGPoint(x: x, y: centerHeight - 300)
    }
    
    func drawParallax() {
        let backParalax = SKNode()
        backParalax.position = CGPoint(x: CGFloat(centerWidth), y: CGFloat(centerHeight))
        let starryNightTexture = SKTexture(imageNamed: "starfield1")
        let height = starryNightTexture.size().height
        let moveGroundSprite = SKAction.moveBy(x: 0, y: -height, duration: TimeInterval(0.012 * height))
        let resetGroundSprite = SKAction.moveBy(x: 0, y: height, duration: 0.0)
        let moveGroundSpritesForever = SKAction.repeatForever(SKAction.sequence([moveGroundSprite,resetGroundSprite]))
        
        for i in -1...1 {
            let sprite = SKSpriteNode(texture: starryNightTexture)
            sprite.position = CGPoint(x: -centerWidth, y: CGFloat(i) * sprite.size.height)
            sprite.run(moveGroundSpritesForever)
            backParalax.addChild(sprite)
            backParalax.zPosition = -10
            backParalax.speed = 1
        }
        anchorNode.addChild(backParalax)
    }
    
    //add Puck
    func addPuck() {
        
        // Ensures no pucks pre-exist
        for whatDaPuck in anchorNode.children {
            if let name = whatDaPuck.name, name == "ball" {
                whatDaPuck.removeFromParent()
            }
        }
        
        ballNode = nil
        ballNode = SKSpriteNode()
        
        let ballEmoji = SKLabelNode(fontNamed:"SpaceBarColors")
        ballEmoji.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        ballEmoji.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        ballEmoji.alpha = 1.0
        ballEmoji.position = CGPoint(x: 0, y: 0)
        ballEmoji.zPosition = 50
        
        ballEmoji.text = Global.shared.gameBall[settings.puck]
        ballEmoji.fontSize = 54 //* 2
        
        let rnd = arc4random_uniform(UInt32(360))
        ballEmoji.zRotation = CGFloat(Int(rnd).degrees)
        
        if let texture = view?.texture(from: ballEmoji) {
            ballNode?.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.1, size: texture.size())
        } else {
            // This fall back should not happen, but we may use this in the future for iOS' that fail
            ballNode?.physicsBody = SKPhysicsBody(circleOfRadius: 27)
        }
        
        ballNode?.physicsBody?.categoryBitMask = ballCategory
        ballNode?.physicsBody?.contactTestBitMask =
            paddleCategory + wallCategory + goalCategory
        
        ballNode?.physicsBody?.collisionBitMask =
            paddleCategory + brickCategory + wallCategory
        
        ballNode?.zPosition = 50
        ballNode?.physicsBody?.affectedByGravity = false
        ballNode?.physicsBody?.isDynamic = true
        ballNode?.physicsBody?.allowsRotation = true
        ballNode?.physicsBody?.friction = 0
        ballNode?.physicsBody?.linearDamping = 0
        ballNode?.physicsBody?.angularDamping = 0
        ballNode?.physicsBody?.restitution = 1.0
        ballNode?.physicsBody?.mass = 1.0
        ballNode?.physicsBody?.fieldBitMask = 0
        ballNode?.name = "ball"
        ballNode?.position = CGPoint(x:0,y:0)
        ballNode?.speed = CGFloat(1.0)
        
        swapper.toggle()
        let negative: CGFloat = swapper ? 1 : 0
        ballNode?.addChild(ballEmoji)
        ballNode?.physicsBody?.velocity = CGVector(dx: initialVelocity / CGFloat(2) * negative, dy: initialVelocity)
        anchorNode.addChild(ballNode!)
        
    }
    
    func removePowerBall() {
        // Ensures no pucks pre-exist
        for whatDaPuck in anchorNode.children {
            if let name = whatDaPuck.name, name.contains("powerball") {
                whatDaPuck.removeFromParent()
            }
        }
    }
    
    //addPower
    func addPowerBall() {
        
        removePowerBall()
        
        let powerNode = SKSpriteNode()
        
        let powerTexture = SKLabelNode(fontNamed:"SpaceBarColors")
        powerTexture.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        powerTexture.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        powerTexture.alpha = 1.0
        powerTexture.position = CGPoint(x: 0, y: 0)
        powerTexture.zPosition = 50
        
        var ball = (settings.puck + 3) % 8
        
        if ball > Global.shared.gameBall.count - 1 {
            ball = Global.shared.gameBall.count - 1
        }
        
        powerTexture.text = Global.shared.gameBall[ball]
        powerTexture.fontSize = 54 //* 2
        
        let rnd = arc4random_uniform(UInt32(360))
        powerTexture.zRotation = CGFloat(Int(rnd).degrees)
        
        if let texture = view?.texture(from: powerTexture) {
            powerNode.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.1, size: texture.size())
        } else {
            // This fall back should not happen, but we may use this in the future for iOS' that fail
            powerNode.physicsBody = SKPhysicsBody(circleOfRadius: 27)
        }
        
        powerNode.physicsBody?.categoryBitMask = powerCategory
        powerNode.physicsBody?.contactTestBitMask =
            paddleCategory + wallCategory
        
        powerNode.physicsBody?.collisionBitMask =
            paddleCategory + brickCategory + wallCategory
        
        powerNode.zPosition = 50
        powerNode.physicsBody?.affectedByGravity = false
        powerNode.physicsBody?.isDynamic = true
        powerNode.physicsBody?.allowsRotation = true
        powerNode.physicsBody?.friction = 0
        powerNode.physicsBody?.linearDamping = 0
        powerNode.physicsBody?.angularDamping = 0
        powerNode.physicsBody?.restitution = 1.0
        powerNode.physicsBody?.mass = 1.0
        powerNode.physicsBody?.fieldBitMask = 0
        powerNode.name = "powerball"
        powerNode.position = CGPoint(x: -100,y: -100)
        powerNode.speed = CGFloat(1.0)
        
        swapper.toggle()
        let negative: CGFloat = swapper ? 1 : 0
        powerNode.addChild(powerTexture)
        powerNode.physicsBody?.velocity = CGVector(dx: initialVelocity / CGFloat(2) * negative, dy: initialVelocity)
        anchorNode.addChild(powerNode)
        
    }
    
    //Starts up the reading the tilemap
    func tileMapRun(TileMapNode: SKTileMapNode, center: CGPoint) {
        let SpriteNode = SKSpriteNode()
        Drawbricks(BricksNode: SpriteNode, TileMapNode: TileMapNode, center: center)
    }
    
    //Draws our Bricks for us
    func Drawbricks(BricksNode: SKSpriteNode, TileMapNode:SKTileMapNode, center: CGPoint) {
        let rotation = Global.shared.rotation
        let spriteLabelNode = SKLabelNode(fontNamed:"SpaceBarColors")
        spriteLabelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        spriteLabelNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        spriteLabelNode.alpha = 1.0
        spriteLabelNode.position = CGPoint(x: 0, y: 0)
        spriteLabelNode.fontSize = 50
        spriteLabelNode.zRotation = CGFloat(Int(rotation[settings.currentlevel % rotation.count]).degrees)
        
        let artwork = levelart[settings.currentlevel % levelart.count]
        
        if let art = artwork {
            let coinToss = Int(arc4random_uniform(UInt32(art.count)) )
            spriteLabelNode.text = art[coinToss]
            BricksNode.addChild(spriteLabelNode)
        }
        
        if let texture = view?.texture(from: spriteLabelNode) {
            BricksNode.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.1, size: texture.size())
        } else {
            // This fall back should not happen, but we may use this in the future for iOS' that fail
            BricksNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        }
        
        BricksNode.zPosition = 50
        BricksNode.physicsBody?.restitution = 1.0
        BricksNode.physicsBody?.categoryBitMask = brickCategory
        BricksNode.physicsBody?.collisionBitMask = ballCategory + powerCategory
        BricksNode.physicsBody?.fieldBitMask = ballCategory + powerCategory
        BricksNode.physicsBody?.contactTestBitMask = ballCategory + powerCategory
        BricksNode.physicsBody?.allowsRotation = false
        BricksNode.physicsBody?.affectedByGravity = false
        BricksNode.physicsBody?.isDynamic = false
        BricksNode.physicsBody?.pinned = false
        BricksNode.physicsBody?.isResting = false
        BricksNode.physicsBody?.friction = 0.0
        BricksNode.physicsBody?.mass = 1.0
        BricksNode.name = "brick"
        BricksNode.position = center
        
        space?.addChild(BricksNode)
    }
    
    func drawBricks(BricksTileMap: SKTileMapNode)  {
        for col in (0 ..< BricksTileMap.numberOfColumns) {
            for row in (0 ..< BricksTileMap.numberOfRows) {
                if let _ = BricksTileMap.tileDefinition(atColumn: col, row: row) {
                    let center = BricksTileMap.centerOfTile(atColumn: col, row: row)
                    tileMapRun(TileMapNode: BricksTileMap, center: center)
                }
            }
        }
        BricksTileMap.removeAllChildren()
        BricksTileMap.removeFromParent()
    }
    
    
    override func didMove(to view: SKView) {
        
        speed = 1.0
        drawParallax()
        
        //setup physicsWorld
        physicsWorld.gravity.dx = 0
        physicsWorld.gravity.dy = 0
        physicsWorld.contactDelegate = self
        
        screenType = ScreenSize.shared.setSceneSizeForGame(scene: self, size: initialScreenSize)
        
        levelart[3] =  ["😀","😃","😄","😁","😆","😅","😂","🤣"]
        levelart[2] =  ["😍","🥰","😘","😗","😙","😚","😋","😛"]
        levelart[1] =  ["😝","😜","🤪","🤨","🧐","🤓","😎","🥸"]
        levelart[0] =  ["🤩","🥳","😏","😒","😞","😔","😟","😕"]
        
        width = (scene?.size.width)!
        height = (scene?.size.height)!
        
        centerWidth = width / 2
        centerHeight = height / 2
        
        //stand in for our anchorPoint
        //this is used because our scene's anchor is 0,0
        //for the field node to work properly
        anchor = CGPoint(x: centerWidth, y: centerHeight)
        anchorNode.position = anchor
        addChild(anchorNode)
        
        
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
        levelLabel.text = String(settings.currentlevel + 1)
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
        
        //left mid corner piece
        let leftMidNode = SKSpriteNode()
        let leftMidTexture = SKTexture(imageNamed: "leftmid")
        let leftMidBody =  SKPhysicsBody(texture: leftMidTexture, alphaThreshold: 0.1, size: leftMidTexture.size())
        leftMidNode.texture = leftMidTexture
        leftMidNode.physicsBody = leftMidBody
        leftMidNode.physicsBody?.friction = 0
        leftMidNode.physicsBody?.fieldBitMask = 0
        leftMidNode.physicsBody?.contactTestBitMask = ballCategory
        leftMidNode.physicsBody?.categoryBitMask = wallCategory
        leftMidNode.physicsBody?.collisionBitMask = wallCategory + ballCategory
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
        rightMidNode.physicsBody?.categoryBitMask = wallCategory
        rightMidNode.physicsBody?.collisionBitMask = wallCategory + ballCategory
        rightMidNode.physicsBody?.restitution = 1.0
        rightMidNode.physicsBody?.mass = 1
        rightMidNode.physicsBody?.isDynamic = false
        rightMidNode.physicsBody?.affectedByGravity = false
        rightMidNode.size = CGSize(width: 32, height: 64)
        rightMidNode.position = CGPoint(x: centerWidth - (corneredge / 2) ,y: 0)
        anchorNode.addChild(rightMidNode)
        
        //centercourt circle
        let centerCourtNode = SKSpriteNode()
        let centerCourtTexture = SKTexture(imageNamed: "centercourt")
        centerCourtNode.texture = centerCourtTexture
        centerCourtNode.size = centerCourtTexture.size()
        centerCourtNode.position = CGPoint(x:0,y:0)
        anchorNode.addChild(centerCourtNode)
        
        //centercourt line
        let centerCourtLineNode = SKSpriteNode()
        let centerCourtLineTexture = SKTexture(imageNamed: "centerline")
        centerCourtLineNode.texture = centerCourtLineTexture
        centerCourtLineNode.size = CGSize(width: (-centerWidth * 4) + 64, height: 4)
        centerCourtLineNode.position = CGPoint(x:0,y:0)
        //MARK: - For testing if pattern is centered left to right
        //centerCourtLineNode.zRotation = 90.degrees
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
        lowerLeftNode.physicsBody?.categoryBitMask = wallCategory
        lowerLeftNode.physicsBody?.collisionBitMask = wallCategory + ballCategory
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
        lowerRightNode.physicsBody?.categoryBitMask = wallCategory
        lowerRightNode.physicsBody?.collisionBitMask = wallCategory + ballCategory
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
        upperLeftNode.physicsBody?.categoryBitMask = wallCategory
        upperLeftNode.physicsBody?.collisionBitMask = wallCategory + ballCategory
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
        upperRightNode.physicsBody?.categoryBitMask = wallCategory
        upperRightNode.physicsBody?.collisionBitMask = wallCategory + ballCategory
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
        //let paddlePhysicsBody = SKPhysicsBody(rectangleOf: paddleTexture.size())
        
        if let paddle = Optional(SKSpriteNode()) {
            paddle.texture = paddleTexture
            paddle.physicsBody = paddlePhysicsBody
            paddle.physicsBody?.friction = 0
            paddle.physicsBody?.allowsRotation = false
            paddle.physicsBody?.linearDamping = 0
            paddle.physicsBody?.angularDamping = 0
            paddle.zPosition = 50
            paddle.physicsBody?.isDynamic = false
            paddle.physicsBody?.fieldBitMask = 0
            paddle.physicsBody?.affectedByGravity = false
            paddle.physicsBody?.mass = 1
            paddle.physicsBody?.contactTestBitMask = ballCategory
            paddle.physicsBody?.categoryBitMask = paddleCategory
            paddle.physicsBody?.collisionBitMask = ballCategory
            
            //leave as is for now until we decide to use convert point or not
            paddle.position = CGPoint(x:frame.width / 2,y:frame.height / paddleHeight)
            paddle.size = CGSize(width: 130.0, height: 40.0) //Needed to size
            paddle.physicsBody?.restitution = 1.0
            paddle.name = "paddle"
            paddleNode = paddle
            scene?.addChild(paddle)
        }
        
        if let goalNode = Optional(SKSpriteNode()) {
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
        }
        
        drawLevel()
        
        let getReadyLabel = SKLabelNode(fontNamed:"emulogic")
        
        let decay = SKAction.wait(forDuration: 1.0)
        let levelUpCode = SKAction.run { [unowned self] in
            
            let getReady = "GET READY"
            getReadyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            getReadyLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            getReadyLabel.alpha = 1.0
            getReadyLabel.position = CGPoint(x: 0, y: 0)
            getReadyLabel.zPosition = 50
            getReadyLabel.text = getReady
            getReadyLabel.fontSize = 46
            getReadyLabel.alpha = 1.0
            anchorNode.addChild(getReadyLabel)
            
            if let lvl = levelLabel.text {
                speech("Level \(lvl). Get Ready!")
            }
        }
        
        let fadeAlpha = SKAction.fadeOut(withDuration: 0.5)
        let runcode1 = SKAction.run {
            getReadyLabel.run(fadeAlpha)
        }
        
        let runcode2 = SKAction.run { [unowned self] in
            addPuck()
            
            if (settings.currentlevel + 1) % 10 == 0 {
                addPowerBall()
            }
            
        }
        
        run(SKAction.sequence([levelUpCode,decay,runcode1,decay,runcode2]))
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        let constraint = CGFloat(64)
        if (pos.x >= constraint && pos.x <= frame.width - constraint) {
            let action = SKAction.moveTo(x: pos.x, duration: 0.002)
            paddleNode?.run(action)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        let constraint = CGFloat(64)
        if (pos.x >= constraint && pos.x <= frame.width - constraint) {
            let action = SKAction.moveTo(x: pos.x, duration: 0.002)
            paddleNode?.run(action)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
    
    
    func resetGameBoard(lives: Bool) {
        
        for removePowerball in anchorNode.children {
            if let name = removePowerball.name, name.contains("ball") {
                removePowerball.removeFromParent()
            }
        }
        
        space?.removeAllChildren()
        space?.removeFromParent()
        space?.removeAllActions()
        space = nil
        settings.currentlevel += 1
        settings.currentlevel %= Global.shared.levels.count
        gameLives = gameLives < 5 ? gameLives + 1 : gameLives
        livesLabel.text = String(gameLives)
        levelLabel.text = String(settings.currentlevel + 1)
        scoreLabel.text = String(gameScore)
        setHighScore()
        appSettings.saveUserDefaults()
        drawLevel()
        
        let getReadyLabel = SKLabelNode(fontNamed:"emulogic")
        
        let decay1 = SKAction.wait(forDuration: 3.0)
        let decay2 = SKAction.wait(forDuration: 1.5)
        let levelUpCode = SKAction.run { [unowned self] in
            
            let getReadyText = "GET READY"
            getReadyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            getReadyLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            getReadyLabel.alpha = 1.0
            getReadyLabel.position = CGPoint(x: 0, y: 0)
            getReadyLabel.zPosition = 50
            getReadyLabel.text = getReadyText
            getReadyLabel.fontSize = 46
            getReadyLabel.alpha = 1.0
            anchorNode.addChild(getReadyLabel)
            
            if let lvl = levelLabel.text, let score = scoreLabel.text  {
                speech("Level \(lvl). Score \(score). Get Ready!")
            }
        }
        
        
        let fadeAlpha = SKAction.fadeOut(withDuration: 0.5)
        let runcode1 = SKAction.run {
            getReadyLabel.run(fadeAlpha)
        }
        
        let runcode2 = SKAction.run { [unowned self] in
            addPuck()
            
            for whatDaPuck in anchorNode.children {
                if let name = whatDaPuck.name, name == "powerball" {
                    whatDaPuck.removeFromParent()
                }
            }
            
            if settings.currentlevel % 7 == 0 {
                addPowerBall()
            }
        }
        
        run(SKAction.sequence([levelUpCode,decay1,runcode1,decay2,runcode2]))
    }
    
    fileprivate func checker(_ firstBody: SKPhysicsBody) {
        // There are two mysterious "bricks" that do not seem to exist
        if let count = space?.children.count, count - 1 <= 0  {
            
            let a = SKAction.fadeAlpha(to: 0, duration: 0.25)
            let b = SKAction.removeFromParent()
            let c = SKAction.wait(forDuration: 0.5)
            let d = SKAction.run { [unowned self] in
                resetGameBoard(lives: true)
            }
            
            if let ball = firstBody.node {
                ball.run(SKAction.sequence([a,b]))
            }
            
            run(SKAction.sequence([c,d]))
        }
    }
    
    func speech(_ text: String) {
        DispatchQueue.global(qos: .background).async {
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
            utterance.rate = 0.5
            utterance.volume = 2.0
            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(utterance)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        guard
            let _ = contact.bodyA.node,
            let _ = contact.bodyB.node
        else {
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
        
        swapper.toggle()
        let rotateAction = SKAction.rotate(byAngle: .pi * CGFloat(swapper ? 1 : -1), duration: 2)
        
        if firstBody.node?.name == "ball" {
            firstBody.node?.run(rotateAction)
            firstBody.node?.run(rotateAction)
        } else if secondBody.node?.name == "ball" {
            secondBody.node?.run(rotateAction)
            secondBody.node?.run(rotateAction)
        }
        
        switch catMask {
        
        case ballCategory | brickCategory, powerCategory | brickCategory :
            if settings.sound { run(brickSound) }
            gameScore += 1
            
            scoreLabel.text = String(gameScore)
            if let a = secondBody.node {
                a.removeFromParent()
                checker(firstBody)
            }
         
        case powerCategory | wallCategory:
            guard
                let ballNode = firstBody.node,
                let x = ballNode.physicsBody?.velocity.dx,
                let y = ballNode.physicsBody?.velocity.dy,
                let body = ballNode.physicsBody
            else {
                return
            }
            
            if ballNode.name != "powerball" {return}
            
            func booster(_ ballBody: SKPhysicsBody?, _ boost: CGFloat, _ initialVelocity: CGFloat ) {
                guard let ballBody = ballBody else { return }
                
                if abs(ballBody.velocity.dx) < abs(initialVelocity / halfLife) {
                    ballBody.velocity.dx <= zero ? (ballBody.velocity.dx -= boost) : (ballBody.velocity.dx += boost)
                }
                
                if abs(ballBody.velocity.dy) < abs(initialVelocity) {
                    ballBody.velocity.dy <= zero ? (ballBody.velocity.dy -= boost * halfLife) : (ballBody.velocity.dy += boost * halfLife)
                }
            }
            
            let absTotal = abs(x) + abs(y)
            
            if absTotal <= initialVelocity * ratio {
                booster(body, boost, initialVelocity)
            } else if absTotal > initialVelocity * ratio + differentiator {
                booster(body, -boost / halfLife, initialVelocity + differentiator)
            }
        case ballCategory | wallCategory :
            
            if settings.sound { run(wallSound) }
            
        case ballCategory | goalCategory:
            firstBody.node?.removeFromParent()
            if settings.sound { run(goalSound) }
            
            gameLives -= 1
            
            //lives to come
            if gameLives > 0 {
                addPuck()
            }
            
            if gameLives < 0 {
                gameLives = 0
            }
            
            if gameLives == 0 && gameOver == nil {
                gameOver = true
                
                removePowerBall()
                
                let getReadyLabel = SKLabelNode(fontNamed:"emulogic")
                
                let decay1 = SKAction.wait(forDuration: 1.0)
                let decay2 = SKAction.wait(forDuration: 2.0)
                let gameOverCode = SKAction.run { [unowned self] in
                    
                    let getReadyText = "GAME OVER"
                    getReadyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                    getReadyLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
                    getReadyLabel.alpha = 1.0
                    getReadyLabel.position = CGPoint(x: 0, y: 0)
                    getReadyLabel.zPosition = 50
                    getReadyLabel.text = getReadyText
                    getReadyLabel.fontSize = 46
                    getReadyLabel.alpha = 1.0
                    anchorNode.addChild(getReadyLabel)
                    
                    if let score = scoreLabel.text {
                        speech("Game Over. You scored \(score) points!")
                    }
                }
                
                let runcode = SKAction.run {
                    NotificationCenter.default.post(name: Notification.Name("loadGameView"), object: nil)
                }
                
                anchorNode.run(SKAction.sequence([decay1,gameOverCode,decay2,runcode]))
            }
            
            livesLabel.text = String(gameLives)
            
        case ballCategory | paddleCategory, powerCategory | paddleCategory:
            if settings.sound { run(paddleSound) }
            scoreLabel.text = String(gameScore)
        default:
            break
        }
        
        setHighScore()
    }
    
    // Called before each frame is rendered
    override func update(_ currentTime: TimeInterval) {
        guard
            let ballNode = ballNode,
            let x = ballNode.physicsBody?.velocity.dx,
            let y = ballNode.physicsBody?.velocity.dy,
            let body = ballNode.physicsBody
        else {
            return
        }
        
        if ballNode.name != "ball" {return}
        
        func booster(_ ballBody: SKPhysicsBody?, _ boost: CGFloat, _ initialVelocity: CGFloat ) {
            guard let ballBody = ballBody else { return }
            
            if abs(ballBody.velocity.dx) < abs(initialVelocity / halfLife) {
                ballBody.velocity.dx <= zero ? (ballBody.velocity.dx -= boost) : (ballBody.velocity.dx += boost)
            }
            
            if abs(ballBody.velocity.dy) < abs(initialVelocity) {
                ballBody.velocity.dy <= zero ? (ballBody.velocity.dy -= boost * halfLife) : (ballBody.velocity.dy += boost * halfLife)
            }
        }
        
        let absTotal = abs(x) + abs(y)
        
        if absTotal <= initialVelocity * ratio {
            booster(body, boost, initialVelocity)
        } else if absTotal > initialVelocity * ratio + differentiator {
            booster(body, -boost / halfLife, initialVelocity + differentiator)
        }
    }
}
