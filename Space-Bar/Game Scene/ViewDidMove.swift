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
        physicsWorld.gravity.dx =  0
        physicsWorld.gravity.dy =  -0.15
        physicsWorld.contactDelegate = self
        
        screenType = ScreenSize.shared.setSceneSizeForGame(scene: self, size: initialScreenSize)
        
        //Our custom font maps emoji's to vector graphics - Kind of old school to classic 8 bit games
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
        
        centerWidth  = width / 2
        centerHeight = height / 2
        
        //stand in for our anchorPoint
        //this is used because our scene's anchor is 0,0
        //for the field node to work properly
        anchor = CGPoint(x: centerWidth, y: centerHeight)
        anchorNode.position = anchor
        addChild(anchorNode)
        
        //MARK: - Game Frame
        let frame = CGRect(x: -centerWidth, y: -centerHeight, width: width, height: height)
        
        drawHUD()
        drawEdgeLoop(frame)
        drawMidCorners()
        drawCenterCourt()
        drawWalls()
        drawGoal()
        drawPaddle()
        drawLevel()
    
        getReady()
    }
}
