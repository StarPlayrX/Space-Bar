//
//  ViewDidMove.swift
//  Space-Bar
//
//  Created by Todd Bruss on 11/7/22.
//  Copyright © 2022 Todd Bruss. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    override func didMove(to view: SKView) {
        speed = 1.0
        drawParallax()
        
        //setup physicsWorld
        physicsWorld.gravity.dx =  -0.334
        physicsWorld.gravity.dy =  -0.667
        physicsWorld.contactDelegate = self
        
        screenType = ScreenSize.shared.setSceneSizeForGame(scene: self, size: initialScreenSize)
        
        levelart[0] = ["🤩","🥳","😏","😒","😞","😔","😟","😕"]
        levelart[1] = ["😝","😜","🤪","🤨","🧐","🤓","😎","🥸"]
        levelart[2] = ["😍","🥰","😘","😗","😙","😚","😋","😛"]
        levelart[3] = ["😀","😃","😄","😁","😆","😅","😂","🤣"]
        
        guard
            let w = scene?.size.width,
            let h = scene?.size.height
        else {
            return
        }
        
        width  = w
        height = h
        
        centerWidth = width / 2
        centerHeight = height / 2
        
        var recessedWallWidth = centerWidth
        print(centerWidth)
        
        //stand in for our anchorPoint
        //this is used because our scene's anchor is 0,0
        //for the field node to work properly
        anchor = CGPoint(x: centerWidth, y: centerHeight)
        anchorNode.position = anchor
        addChild(anchorNode)
        
        livesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        livesLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        livesLabel.alpha = 1.0
        livesLabel.position = CGPoint(x: centerWidth, y: centerHeight - labelspace)
        livesLabel.zPosition = 50
        let puck = Global.shared.gameBall[settings.puck]
        livesLabel.text = String(repeating: puck, count: gameLives)
        livesLabel.fontSize = 36
        //livesLabel.fontColor = UIColor.init(red: 247 / 255, green: 147 / 255, blue: 30 / 255, alpha: 1.0)
        livesLabel.alpha = 1.0
        anchorNode.addChild(livesLabel)
        
        levelLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        levelLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        levelLabel.alpha = 1.0
        levelLabel.position = CGPoint(x: -centerWidth + 20, y: centerHeight - labelspace)
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
        
        let centerLineBody =  SKPhysicsBody(texture: rightMidTexture, alphaThreshold: 0.1, size: rightMidTexture.size())
        centerCourtLineNode.physicsBody = centerLineBody
        
        centerCourtLineNode.physicsBody?.contactTestBitMask = ballCategory
        centerCourtLineNode.physicsBody?.categoryBitMask = midFieldCategory
        centerCourtLineNode.physicsBody?.collisionBitMask = midFieldCategory + ballCategory
        centerCourtLineNode.physicsBody?.isDynamic = false
        centerCourtLineNode.physicsBody?.affectedByGravity = false
        centerCourtLineNode.size = CGSize(width:centerWidth * 2 - 64, height: 4)
        centerCourtLineNode.position = CGPoint(x:0,y:0)
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
        lowerLeftNode.position = CGPoint(x: -centerWidth + corneredge,y: -centerHeight + 98)
        anchorNode.addChild(lowerLeftNode)
        
        print("LL width:", lowerLeftNode.size.width)
        
        recessedWallWidth -= lowerLeftNode.size.width
        
        //lower right corner
        let lowerRightNode = SKSpriteNode()
        let lowerRightTexture = SKTexture(imageNamed: "lr")
        let lowerRightBody = SKPhysicsBody(texture: lowerRightTexture, alphaThreshold: 0.1, size: lowerRightTexture.size())
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
        lowerRightNode.position = CGPoint(x:centerWidth - corneredge,y: -centerHeight + 98)
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
        
        let paddle = SKSpriteNode()
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
        
        let goalWallRightNode = SKSpriteNode()
        let goalWallTexture = SKTexture(imageNamed: "goalwallRight")
        let goalWallPhysicsBody = SKPhysicsBody(texture: goalWallTexture, alphaThreshold: 0.1, size: goalWallTexture.size())
        goalWallRightNode.texture = goalWallTexture
        goalWallRightNode.physicsBody = goalWallPhysicsBody
        goalWallRightNode.physicsBody?.affectedByGravity = false
        goalWallRightNode.physicsBody?.friction = 0
        goalWallRightNode.physicsBody?.fieldBitMask = 0
        goalWallRightNode.physicsBody?.allowsRotation = false
        goalWallRightNode.physicsBody?.linearDamping = 0
        goalWallRightNode.physicsBody?.angularDamping = 0
        goalWallRightNode.zPosition = 0
        goalWallRightNode.physicsBody?.isDynamic = false
        goalWallRightNode.physicsBody?.mass = 1.0
        goalWallRightNode.physicsBody?.contactTestBitMask = ballCategory
        goalWallRightNode.physicsBody?.categoryBitMask = wallCategory
        goalWallRightNode.physicsBody?.collisionBitMask = wallCategory + ballCategory
        goalWallRightNode.position = CGPoint(x: 130, y: -centerHeight + 30)
        goalWallRightNode.size = CGSize(width: goalWallTexture.size().width, height: goalWallTexture.size().height)
        goalWallRightNode.physicsBody?.restitution = 0.25
        goalWallRightNode.name = "wall"
        anchorNode.addChild(goalWallRightNode)
        
        print("goalWallRightNode:", goalWallRightNode.size.width)
        
        let goalWallLeftNode = SKSpriteNode()
        let goalWallLeftTexture = SKTexture(imageNamed: "goalwallLeft")
        let goalWallLeltPhysicsBody = SKPhysicsBody(texture: goalWallLeftTexture, alphaThreshold: 0.1, size: goalWallLeftTexture.size())
        goalWallLeftNode.texture = goalWallLeftTexture
        goalWallLeftNode.physicsBody = goalWallLeltPhysicsBody
        goalWallLeftNode.physicsBody?.affectedByGravity = false
        goalWallLeftNode.physicsBody?.friction = 0
        goalWallLeftNode.physicsBody?.fieldBitMask = 0
        goalWallLeftNode.physicsBody?.allowsRotation = false
        goalWallLeftNode.physicsBody?.linearDamping = 0
        goalWallLeftNode.physicsBody?.angularDamping = 0
        goalWallLeftNode.zPosition = 0
        goalWallLeftNode.physicsBody?.isDynamic = false
        goalWallLeftNode.physicsBody?.mass = 1.0
        goalWallLeftNode.physicsBody?.contactTestBitMask = ballCategory
        goalWallLeftNode.physicsBody?.categoryBitMask = wallCategory
        goalWallLeftNode.physicsBody?.collisionBitMask = wallCategory + ballCategory
        goalWallLeftNode.position = CGPoint(x: -130, y: -centerHeight + 30)
        goalWallLeftNode.size = CGSize(width: goalWallLeftTexture.size().width, height: goalWallLeftTexture.size().height) //Needed to size
        goalWallLeftNode.physicsBody?.restitution = 0.25
        goalWallLeftNode.name = "wall"
        anchorNode.addChild(goalWallLeftNode)
        
        print("goalWallLeftNode:", goalWallLeftNode.size.width)
        
        recessedWallWidth -= goalWallLeftNode.size.width
        
        let goalNode = SKSpriteNode()
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
        goalNode.physicsBody?.mass = 1.0
        goalNode.physicsBody?.contactTestBitMask = ballCategory
        goalNode.physicsBody?.categoryBitMask = goalCategory
        goalNode.position = CGPoint(x:0,y:-centerHeight)
        goalNode.size = CGSize(width: goalTexture.size().width, height: goalTexture.size().height) //Needed to size
        goalNode.physicsBody?.restitution = 0
        goalNode.name = "goal"
        anchorNode.addChild(goalNode)
        
        print("goalWallRightNode:", goalNode.size.width)
        
        recessedWallWidth -= goalNode.size.width / 2
        
        let recessWallNodeR = SKSpriteNode()
        let recessWallTextureR = SKTexture(imageNamed: "recessedWall")
        let recessWallPhysicsBodyR = SKPhysicsBody(texture: recessWallTextureR, alphaThreshold: 0.1, size: recessWallTextureR.size())
        recessWallNodeR.texture = recessWallTextureR
        recessWallNodeR.physicsBody = recessWallPhysicsBodyR
        recessWallNodeR.physicsBody?.affectedByGravity = false
        recessWallNodeR.physicsBody?.friction = 0
        recessWallNodeR.physicsBody?.allowsRotation = false
        recessWallNodeR.physicsBody?.linearDamping = 0
        recessWallNodeR.physicsBody?.angularDamping = 0
        recessWallNodeR.zPosition = 50
        recessWallNodeR.physicsBody?.isDynamic = false
        recessWallNodeR.physicsBody?.mass = 1.0
        recessWallNodeR.physicsBody?.contactTestBitMask = ballCategory
        recessWallNodeR.physicsBody?.categoryBitMask = wallCategory
        recessWallNodeR.physicsBody?.collisionBitMask = wallCategory + ballCategory
        recessWallNodeR.position = CGPoint(x: (-recessedWallWidth - 130 + 64 - 24) * -1, y: -centerHeight + 30)
        recessWallNodeR.size = CGSize(width: recessedWallWidth + 12, height: recessWallTextureR.size().height)
        recessWallNodeR.physicsBody?.restitution = 0.25
        recessWallNodeR.name = "wall"
        anchorNode.addChild(recessWallNodeR)
        
        
        let recessWallNodeL = SKSpriteNode()
        let recessWallTextureL = SKTexture(imageNamed: "recessedWall")
        let recessWallPhysicsBodyL = SKPhysicsBody(texture: recessWallTextureL, alphaThreshold: 0.1, size: recessWallTextureL.size())
        recessWallNodeL.texture = recessWallTextureL
        recessWallNodeL.physicsBody = recessWallPhysicsBodyL
        recessWallNodeL.physicsBody?.affectedByGravity = false
        recessWallNodeL.physicsBody?.friction = 0
        recessWallNodeL.physicsBody?.allowsRotation = false
        recessWallNodeL.physicsBody?.linearDamping = 0
        recessWallNodeL.physicsBody?.angularDamping = 0
        recessWallNodeL.zPosition = 50
        recessWallNodeL.physicsBody?.isDynamic = false
        recessWallNodeL.physicsBody?.mass = 1.0
        recessWallNodeL.physicsBody?.contactTestBitMask = ballCategory
        recessWallNodeL.physicsBody?.categoryBitMask = wallCategory
        recessWallNodeL.physicsBody?.collisionBitMask = wallCategory + ballCategory
        recessWallNodeL.position = CGPoint(x: (-recessedWallWidth - 130 + 64 - 24) * 1, y: -centerHeight + 30)
        recessWallNodeL.size = CGSize(width: recessedWallWidth + 12, height: recessWallTextureL.size().height)
        recessWallNodeL.physicsBody?.restitution = 0.25
        recessWallNodeL.name = "wall"
        anchorNode.addChild(recessWallNodeL)
        
        drawLevel()
        
        let getReadyLabel = SKLabelNode(fontNamed:"emulogic")
        
        let decay = SKAction.wait(forDuration: 1.5)
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
            
            if let lvl = levelLabel.text, let score = scoreLabel.text, score == "0", settings.sound {
                try? speech("Level \(lvl). You have \(gameLives) lives. Get Ready!")
            }
        }
        
        let fadeAlpha = SKAction.fadeOut(withDuration: 0.5)
        let runcode1 = SKAction.run {
            getReadyLabel.run(fadeAlpha)
        }
        
        let runcode2 = SKAction.run { [unowned self] in
            addPuck()
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                self.ballCounter -= 1
                
                if self.ballCounter < 0 {
                    self.ballCounter = self.ballTimeOut
                    self.addPuck()
                }
            }
            
            if (settings.currentlevel + 1) % 10 == 0 {
                addPowerBall()
            }
            
        }
        
        run(SKAction.sequence([levelUpCode,decay,runcode1,decay,runcode2]))
    }
}
