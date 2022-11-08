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
        livesLabel.alpha = 0.5
        anchorNode.addChild(livesLabel)
        
        levelLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        levelLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        levelLabel.alpha = 0.5
        levelLabel.position = CGPoint(x: -centerWidth + 20, y: centerHeight - labelspace)
        levelLabel.zPosition = 50
        levelLabel.text = String(settings.currentlevel + 1)
        levelLabel.fontSize = 36
        levelLabel.fontColor = .systemRed
        anchorNode.addChild(levelLabel)
        
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        scoreLabel.alpha = 0.5
        scoreLabel.fontColor = .systemBlue
        scoreLabel.position = CGPoint(x: 0, y: centerHeight - labelspace)
        scoreLabel.zPosition = 50
        scoreLabel.text = String(gameScore)
        scoreLabel.fontSize = 36
        anchorNode.addChild(scoreLabel)
        
        //MARK: - Game Frame
        let frame = CGRect(x: -centerWidth, y: -centerHeight, width: width, height: height)
        
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
        let centerLineBody = SKPhysicsBody(texture: rightMidTexture, alphaThreshold: 0.1, size: rightMidTexture.size())
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
    
        let goalWallRightNode = SKSpriteNode()
        //let goalWalRightTexture = SKTexture(imageNamed: "goalwallLeft")
        let goalWallRightPhysicsBody =  SKPhysicsBody(rectangleOf: CGSize(width: 4, height: 64))
        goalWallRightNode.color = .systemRed
        goalWallRightNode.physicsBody = goalWallRightPhysicsBody
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
        goalWallRightNode.position = CGPoint(x: centerWidth / 3 + 2, y: -centerHeight + 32)
        goalWallRightNode.size = CGSize(width: 4, height: 64) //Needed to size
        goalWallRightNode.physicsBody?.restitution = 0.25
        goalWallRightNode.name = "wall"
        anchorNode.addChild(goalWallRightNode)
                
        let goalWallLeftNode = SKSpriteNode()
        //let goalWallLeftTexture = SKTexture(imageNamed: "goalwallLeft")
        let goalWallLeftPhysicsBody =  SKPhysicsBody(rectangleOf: CGSize(width: 4, height: 64))
        goalWallLeftNode.color = .systemRed
        goalWallLeftNode.physicsBody = goalWallLeftPhysicsBody
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
        goalWallLeftNode.position = CGPoint(x: (centerWidth / -3) - 2, y: -centerHeight + 32)
        goalWallLeftNode.size = CGSize(width: 4, height: 64) //Needed to size
        goalWallLeftNode.physicsBody?.restitution = 0.25
        goalWallLeftNode.name = "wall"
        anchorNode.addChild(goalWallLeftNode)
            
        
        let goalNode = SKSpriteNode()
        let goalPhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width / 3, height: 4))
        goalNode.color = .systemRed
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
        goalNode.position = CGPoint(x:0,y:-centerHeight + 2)
        goalNode.size = CGSize(width: width / 3, height: 4) //Needed to size
        goalNode.physicsBody?.restitution = 0
        goalNode.name = "goal"
        anchorNode.addChild(goalNode)
        
        let recessWallNodeR = SKSpriteNode()
        recessWallNodeR.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width / 3, height: 4))
        recessWallNodeR.color = .systemBlue
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
        recessWallNodeR.position = CGPoint(x: (width + 2) / -3, y: -centerHeight + 64)
        recessWallNodeR.size = CGSize(width: (width + 2) / 3, height: 4)
        recessWallNodeR.physicsBody?.restitution = 0.25
        recessWallNodeR.name = "wall"
        anchorNode.addChild(recessWallNodeR)
        
        let recessWallNodeL = SKSpriteNode()
        recessWallNodeL.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width / 3, height: 4))
        recessWallNodeL.color = .systemBlue
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
        recessWallNodeL.position = CGPoint(x: (width + 2) / 3, y: -centerHeight + 64)
        recessWallNodeL.size = CGSize(width: (width + 2) / 3, height: 4)
        recessWallNodeL.physicsBody?.restitution = 0.25
        recessWallNodeL.name = "wall"
        anchorNode.addChild(recessWallNodeL)
        
        //add our paddle
        let paddleTexture = SKTexture(imageNamed: "paddle")
        let paddlePhysicsBody = SKPhysicsBody(texture: paddleTexture, alphaThreshold: 0.1, size: paddleTexture.size())
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
        paddle.position = CGPoint(x:frame.width / 2,y:frame.height / paddleHeight)
        paddle.size = CGSize(width: paddleTexture.size().width, height: paddleTexture.size().height)
        paddle.physicsBody?.restitution = 1.0
        paddle.name = "paddle"
        paddleNode = paddle
        scene?.addChild(paddle)
        
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
